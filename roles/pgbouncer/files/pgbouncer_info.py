#!/usr/bin/env python
from collections import defaultdict
#from pprint import pprint
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import collectd
import psycopg2

config = {
  'connection_string': 'dbname=pgbouncer user=stats host=127.0.0.1 port=6432'
}

def get_stats():
  print "hit1"
  conn, cur = None, None
  stats = {}
  try:
    conn = psycopg2.connect(config['connection_string'])
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor()
    stats = _get_stats(cur)
  finally:
    if cur is not None:
      cur.close()
      if conn is not None:
        conn.close()

  return stats

def _get_stats(cur):
  print "hit"
  cur.execute("SHOW STATS;")
  stats = defaultdict(dict)
  for database, total, _, _, _, req, recv, sent, query in cur.fetchall():
    stats[database] = {
      'total_requests': total,
      'req_per_sec': req,
      'recv_per_sec': recv,
      'sent_per_sec': sent,
      'avg_query': query
    }

  cur.execute("SHOW POOLS;")
  for database, _, cl_active, cl_waiting, sv_active, sv_idle, sv_used, sv_tested, sv_login, maxwait, _ in cur.fetchall():
    values = {
      'cl_active': cl_active,
      'cl_waiting': cl_waiting,
      'sv_active': sv_active,
      'sv_idle': sv_idle,
      'sv_used': sv_used,
      'sv_tested': sv_tested,
      'sv_login': sv_login,
      'maxwait': maxwait
    }
    if database not in stats:
      stats[database] = dict()
    # there can be many lines for one database, one for each user
    for (metric, value) in values.iteritems():
      if metric in stats[database]:
        stats[database][metric] += value
      else:
        stats[database][metric] = value

  cur.execute("SHOW DATABASES")
  for name, _, _, database, _, pool_size, reserve_pool, _, _, _ in cur.fetchall():
    stats[name]['pool_size'] = pool_size
    stats[name]['reserve_pool'] = reserve_pool
  print stats

  return stats

def pgbouncer_read(data=None):
  stats = get_stats()
  if not stats:
    collectd.error('pgbouncer plugin: No info received')
    return

  for database, metrics in stats.iteritems():
    for metric, value in metrics.iteritems():
      type_instance = '%s.%s' % (database, metric)
      val = collectd.Values(plugin='pgbouncer_info')
      val.type = 'gauge'
      val.type_instance = type_instance
      val.values = [value]
      val.dispatch()


def pgbouncer_config(c):
  for child in c.children:
    value = child.values[0]
    config.update({child.key: value})

#stats=get_stats()
#print stats
collectd.register_read(pgbouncer_read)
collectd.register_config(pgbouncer_config)
