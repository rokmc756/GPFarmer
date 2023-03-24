What are fixed and changed when porting pgbouncer ansible for GPDB and Rocky 8
---------

[1] The following error occurs when staring collected in case Interactive true is set in pgbouncer_gpdb_info.conf
To fix it remove Interactive true in pgbouncer_gpdb_info.conf under /etc/collectd.d directory
~~~
$ tail -f /var/log/messages
Mar 23 16:30:40 rk8-master collectd[153600]: plugin_load: plugin "python" successfully loaded.
Mar 23 16:30:40 rk8-master collectd[153600]: Systemd detected, trying to signal readiness.
Mar 23 16:30:40 rk8-master collectd[153600]: set_thread_name("python interpreter"): name too long
Mar 23 16:30:40 rk8-master systemd[1]: Started Collectd statistics daemon.
Mar 23 16:30:40 rk8-master collectd[153600]: python: Interactive interpreter exited, stopping collectd ...
Mar 23 16:30:40 rk8-master collectd[153600]: Initialization complete, entering read-loop.
Mar 23 16:30:40 rk8-master collectd[153600]: Exiting normally.
~~~

[2] Install pip2 collectd module
~~~
$ pip2 install collectd
WARNING: Running pip install with root privileges is generally not a good idea. Try `pip2 install --user` instead.
Collecting collectd
  Using cached https://files.pythonhosted.org/packages/3c/54/518fe5d323218badc3f7512234cf1dab251c1c591e6650cca29db1c13e9e/collectd-1.0.tar.gz
Installing collected packages: collectd
  Running setup.py install for collectd ... done
Successfully installed collectd-1.0

[root@rk8-master collectd.d]# python
Python 2.7.18 (default, Nov  8 2022, 17:12:04)
[GCC 8.5.0 20210514 (Red Hat 8.5.0-15)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import collectd
~~~

[3] The following error can be firxed after configuring connection_string in pgbouncer_info.py as below
'connection_string': 'dbname=pgbouncer user=stats host=127.0.0.1 port=6432'
Because only pgbouncer database provide SHOW STATS and SHOW POOLS and SHOW DATABASE and so on
~~~
Mar 24 02:21:26 rk8-master collectd[9939]: Unhandled python exception in read callback: ProgrammingError: unrecognized configuration parameter "stats"
Mar 24 02:21:26 rk8-master collectd[9939]: Traceback (most recent call last):
Mar 24 02:21:26 rk8-master collectd[9939]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 74, in pgbouncer_read#012    stats = get_stats()
Mar 24 02:21:26 rk8-master collectd[9939]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 22, in get_stats#012    stats = _get_stats(cur)
Mar 24 02:21:26 rk8-master collectd[9939]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 33, in _get_stats#012    cur.execute("SHOW STATS;")
Mar 24 02:21:26 rk8-master collectd[9939]: psycopg2.ProgrammingError: unrecognized configuration parameter "stats"
Mar 24 02:21:26 rk8-master collectd[9939]: read-function of plugin `python.pgbouncer_info' failed. Will suspend it for 40.000 seconds.
~~~

[4] The following error occurs when getting number of columns from return output of SHOW STATS and SHOW POOLS in pgbouncer_gpdb_info.py
~~~
Mar 24 02:48:48 rk8-master collectd[11188]: Unhandled python exception in read callback: ValueError: too many values to unpack (expected 9)
Mar 24 02:48:48 rk8-master collectd[11188]: Traceback (most recent call last):
Mar 24 02:48:48 rk8-master collectd[11188]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 73, in pgbouncer_read#012    stats = get_stats()
Mar 24 02:48:48 rk8-master collectd[11188]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 21, in get_stats#012    stats = _get_stats(cur)
Mar 24 02:48:48 rk8-master collectd[11188]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 34, in _get_stats#012    for database, total, _, _, _, req, recv, sent, query in cur.fetchall():
Mar 24 02:48:48 rk8-master collectd[11188]: ValueError: too many values to unpack (expected 9)
Mar 24 02:48:48 rk8-master collectd[11188]: read-function of plugin `python.pgbouncer_info' failed. Will suspend it for 20.000 seconds.
~~~


The below patch fixes above error after changing the number of columns in the return output of SHOW STATS, SHOW POOLS, SHOW DATABASES pgbouncer command in pgbouncer_gpdb_info.py\
Because these commands on pgbouncer of greenplum returns much more columns than postgresql's one.
~~~
$ diff -Nur pgbouncer_info.py pgbouncer_gpdb_info.py
--- pgbouncer_info.py	2023-03-23 04:25:31.000000000 +0900
+++ pgbouncer_gpdb_info.py	2023-03-25 01:53:04.000000000 +0900
@@ -10,7 +10,7 @@
 }

 def get_stats():
-  print "hit1"
+  print ("hit1")
   conn, cur = None, None
   stats = {}
   try:
@@ -27,10 +27,10 @@
   return stats

 def _get_stats(cur):
-  print "hit"
+  print ("hit")
   cur.execute("SHOW STATS;")
   stats = defaultdict(dict)
-  for database, total, _, _, _, req, recv, sent, query in cur.fetchall():
+  for database, total, req, recv, sent, _, query, _, _, _, _, _, _, _, _  in cur.fetchall(): # for GPDB 6.23
     stats[database] = {
       'total_requests': total,
       'req_per_sec': req,
@@ -40,7 +40,7 @@
     }

   cur.execute("SHOW POOLS;")
-  for database, _, cl_active, cl_waiting, sv_active, sv_idle, sv_used, sv_tested, sv_login, maxwait, _ in cur.fetchall():
+  for database, _, cl_active, cl_waiting, _, sv_active, sv_idle, sv_used, sv_tested, sv_login, maxwait, _, _ in cur.fetchall(): # for GPDB 6.22.x
     values = {
       'cl_active': cl_active,
       'cl_waiting': cl_waiting,
@@ -54,17 +54,17 @@
     if database not in stats:
       stats[database] = dict()
     # there can be many lines for one database, one for each user
-    for (metric, value) in values.iteritems():
+    for (metric, value) in values.items():
       if metric in stats[database]:
         stats[database][metric] += value
       else:
         stats[database][metric] = value

   cur.execute("SHOW DATABASES")
-  for name, _, _, database, _, pool_size, reserve_pool, _, _, _ in cur.fetchall():
+  for name, _, _, database, _, pool_size, _, reserve_pool, _, _, _, _, _  in cur.fetchall(): # For GPDB 6.22
     stats[name]['pool_size'] = pool_size
     stats[name]['reserve_pool'] = reserve_pool
-  print stats
+  print (stats)

   return stats

@@ -74,8 +74,8 @@
     collectd.error('pgbouncer plugin: No info received')
     return

-  for database, metrics in stats.iteritems():
-    for metric, value in metrics.iteritems():
+  for database, metrics in stats.items():
+    for metric, value in metrics.items():
       type_instance = '%s.%s' % (database, metric)
       val = collectd.Values(plugin='pgbouncer_info')
       val.type = 'gauge'
~~~


[5] This error is fixed after changing function name from iteritems to items in pgbouncer_gpdb_info.py
~~~
Mar 24 03:05:12 rk8-master collectd[11817]: Unhandled python exception in read callback: AttributeError: 'dict' object has no attribute 'iteritems'
Mar 24 03:05:12 rk8-master collectd[11817]: Traceback (most recent call last):
Mar 24 03:05:12 rk8-master collectd[11817]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 75, in pgbouncer_read#012    stats = get_stats()
Mar 24 03:05:12 rk8-master collectd[11817]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 21, in get_stats#012    stats = _get_stats(cur)
Mar 24 03:05:12 rk8-master collectd[11817]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 60, in _get_stats#012    for (metric, value) in values.iteritems():
Mar 24 03:05:12 rk8-master collectd[11817]: AttributeError: 'dict' object has no attribute 'iteritems'
~~~

See the patch since it's included in it.
~~~
#  for database, metrics in stats.iteritems():
#    for metric, value in metrics.iteritems():
  for database, metrics in stats.items():
    for metric, value in metrics.items():
~~~

This solution was found out at this link - https://stackoverflow.com/questions/30418481/error-dict-object-has-no-attribute-iteritems
