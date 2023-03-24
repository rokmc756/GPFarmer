[ Rocky 8 ]
[1] With python2
alternatives --set python /usr/bin/python2
systemctl start collectd
~~~
Mar 23 16:30:40 rk8-master collectd[153600]: plugin_load: plugin "python" successfully loaded.
Mar 23 16:30:40 rk8-master collectd[153600]: Systemd detected, trying to signal readiness.
Mar 23 16:30:40 rk8-master collectd[153600]: set_thread_name("python interpreter"): name too long
Mar 23 16:30:40 rk8-master systemd[1]: Started Collectd statistics daemon.
Mar 23 16:30:40 rk8-master collectd[153600]: python: Interactive interpreter exited, stopping collectd ...
Mar 23 16:30:40 rk8-master collectd[153600]: Initialization complete, entering read-loop.
Mar 23 16:30:40 rk8-master collectd[153600]: Exiting normally.
~~~
pip3 install collectd
systemctl restart collect

# alternatives --set python /usr/bin/python2
# pip2 install collectd
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
--> No error


moonjaYMD6T:collectd moonja$ less src/daemon/plugin.c
~~~
  /* glibc limits the length of the name and fails if the passed string
   * is too long, so we truncate it here. */
  char n[THREAD_NAME_MAX];
  if (strlen(name) >= THREAD_NAME_MAX)
    WARNING("set_thread_name(\"%s\"): name too long", name);
  sstrncpy(n, name, sizeof(n));
~~~

The following error occurs when staring collected in case Interactive true is set in pgbouncer_info.conf
To fix it remove Interactive true in pgbouncer_info.conf under /etc/collectd.d directory
~~~
Mar 24 01:48:09 rk8-master collectd[8546]: set_thread_name("python interpreter"): name too long
Mar 24 01:48:09 rk8-master systemd[1]: Started Collectd statistics daemon.
Mar 24 01:48:09 rk8-master collectd[8546]: python: Interactive interpreter exited, stopping collectd ...
~~~

The following error can be firxed after configuring connection_string in pgbouncer_info.py as below
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


Fixed the following errors after collecting number of columns from output of SHOW STATS and SHOW POOLS in pgbouncer_info.conf
~~~
Mar 24 02:48:48 rk8-master collectd[11188]: Unhandled python exception in read callback: ValueError: too many values to unpack (expected 9)
Mar 24 02:48:48 rk8-master collectd[11188]: Traceback (most recent call last):
Mar 24 02:48:48 rk8-master collectd[11188]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 73, in pgbouncer_read#012    stats = get_stats()
Mar 24 02:48:48 rk8-master collectd[11188]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 21, in get_stats#012    stats = _get_stats(cur)
Mar 24 02:48:48 rk8-master collectd[11188]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 34, in _get_stats#012    for database, total, _, _, _, req, recv, sent, query in cur.fetchall():
Mar 24 02:48:48 rk8-master collectd[11188]: ValueError: too many values to unpack (expected 9)
Mar 24 02:48:48 rk8-master collectd[11188]: read-function of plugin `python.pgbouncer_info' failed. Will suspend it for 20.000 seconds.
~~~




Fixed after changing function name from iteritems to items in pgbouncer_info.py
~~~
#  for database, metrics in stats.iteritems():
#    for metric, value in metrics.iteritems():
  for database, metrics in stats.items():
    for metric, value in metrics.items():
~~~
https://stackoverflow.com/questions/30418481/error-dict-object-has-no-attribute-iteritems
~~~
Mar 24 03:05:12 rk8-master collectd[11817]: Unhandled python exception in read callback: AttributeError: 'dict' object has no attribute 'iteritems'
Mar 24 03:05:12 rk8-master collectd[11817]: Traceback (most recent call last):
Mar 24 03:05:12 rk8-master collectd[11817]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 75, in pgbouncer_read#012    stats = get_stats()
Mar 24 03:05:12 rk8-master collectd[11817]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 21, in get_stats#012    stats = _get_stats(cur)
Mar 24 03:05:12 rk8-master collectd[11817]:  File "/var/lib/collectd/python/pgbouncer_info.py", line 60, in _get_stats#012    for (metric, value) in values.iteritems():
Mar 24 03:05:12 rk8-master collectd[11817]: AttributeError: 'dict' object has no attribute 'iteritems'
~~~



[2] With python3
alternatives --set python /usr/bin/python3
systemctl start collectd
~~~
Mar 23 16:34:17 rk8-master collectd[153751]: plugin_load: plugin "python" successfully loaded.
Mar 23 16:34:17 rk8-master collectd[153751]: Systemd detected, trying to signal readiness.
Mar 23 16:34:17 rk8-master collectd[153751]: set_thread_name("python interpreter"): name too long
Mar 23 16:34:17 rk8-master systemd[1]: Started Collectd statistics daemon.
Mar 23 16:34:17 rk8-master collectd[153751]: python: Interactive interpreter exited, stopping collectd ...
Mar 23 16:34:17 rk8-master collectd[153751]: Initialization complete, entering read-loop.
Mar 23 16:34:17 rk8-master collectd[153751]: Exiting normally.
~~~

# pip3 install collectd
# python
Python 3.6.8 (default, Feb 21 2023, 16:57:46)
[GCC 8.5.0 20210514 (Red Hat 8.5.0-16)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import collectd
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/usr/local/lib/python3.6/site-packages/collectd.py", line 8, in <module>
    from Queue import Queue, Empty
ModuleNotFoundError: No module named 'Queue'
>>> \q
