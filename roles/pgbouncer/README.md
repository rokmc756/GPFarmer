## PGBouncer Architecture
![alt text](https://github.com/rokmc756/GPFarmer/blob/main/roles/pgbouncer/images/pgbouncer_cmoparision_connectinos.png)

## PGBouncer for Greenplum Database
This role configures PgBouncer for Greenplum database connection mux utility.

Greenplum database's performance degrades when handling a high number of connection due to a 1:1 mapping of connection to Greenplum backend processes. PgBouncer is a threaded pooler which can reduce the number of backend processes and the handshaking involved in setting up a new connection.

This role is cloned from the following github site[1] which is created for Postgres and Ubuntu. Thanks for sharing it. Alexey!!.\
[1] https://github.com/alexey-medvedchikov/ansible-pgbouncer

In this role there are several ansible playbooks modified for RHEL, CentOS and Rocky 8 and Greenplum database as well as configuration of monit and pgbouncer python script for collectd python module.

## Example pgbouncer/vars/main.yml
Ansible handles the templating of userlist.txt, including the md5 hashing.
~~~
$ vi roles/pgbouncer/vars/main.yml
pgbouncer:
  - users:
    - name: testuser
      pass: changeme
    - name: postgres
      pass: changeme
  - databases:
    - name: "db1"
      host: "{{ hostvars[groups['master'][0]]['ansible_eth0']['ipv4']['address'] }}"
      port: 5432
  - max_client_conn: 300
  - max_db_connections: 300
  - max_user_connections: 300
  - default_pool_size: 80
  # govern how many backend connections

monit_protection: true
collectd_monitoring: true
~~~

## Requirements
Module is modified and tested with pgbouncer in greenplum 6.22.x.

## Install and uninstall pgbouncer with collectd and monit by ansible playbook on ansible host
~~~
$ cd /Users/moonja/GPFarmer

$ vi install-hosts.yml
- hosts: rk8-master
  become: true
  gather_facts: true
  roles:
    - { role: pgbouncer }

$ make install

$ vi uninstall-hosts.yml
#
- hosts: rk8-master
  become: true
  gather_facts: true
  roles:
    - { role: pgbouncer }

$ make uninstall
~~~

## Debugging
If pgbouncer fails to start
~~~
[gpadmin@rk8-master ~]$ pgbouncer -d /usr/local/greenplum-db/etc/pgbouncer/pgbouncer.ini -vvvv
~~~
Testing a connection to a remote database
~~~
[gpadmin@rk8-master ~]$ psql -h localhost -p 6432 -U <user_name> <database_name>
~~~
## Stats
The default 1.7.2 configuration provides peer authentication of the pgbouncer database to show stats.
NOTE: this still requires a userlist.txt entry for the postgres user.
~~~
[gpadmin@rk8-master ~]$ psql -p 6432 pgbouncer -c 'show pool;'
[gpadmin@rk8-master ~]$ psql -p 6432 pgbouncer -c 'show stats;'
~~~

# Reloading / Restarting
Key config changes such as pool sizing do not require a full restart
~~~
$ sysemctl reload pgbouncer
~~~

## What are changed and fixed compare to original ansible role
See [Porting-Rocky-8.md](https://github.com/rokmc756/gpfarmer/blob/main/roles/pgbouncer/Porting-Rocky-8.md)

## License
LGPL

## Author Information
- Jack Moon, rokmc756@gmail.com
