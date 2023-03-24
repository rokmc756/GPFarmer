PGBouncer for Greenplum Database
=========

This role configures PgBouncer for Greenplum database connection mux utility.

Greenplum database's performance degrades when handling a high number of connection due to a 1:1 mapping of connection to Greenplum backend processes. PgBouncer is a threaded pooler which can reduce the number of backend processes and the handshaking involved in setting up a new connection.

This role is cloned from the following github site[1] which is created for Postgres and Ubuntu.\
[1] https://github.com/alexey-medvedchikov/ansible-pgbouncer

In this role there are ansible playbooks modified for RHEL, CentOS and Rocky 8 and Greenplum database as well as configuration of monit and pgbouncer python script for collectd python module.

Example pgbouncer/vars/main.yml
---------------------------------

Ansible handles the templating of userlist.txt, including the md5 hashing.

    pgbouncer_users:
      - name: testuser
        pass: changeme
      - name: postgres
        pass: changeme
    # host: changeme

    pgbouncer_databases:
      - name: "db1"
        host: "{{ hostvars[groups['master'][0]]['ansible_eth0']['ipv4']['address'] }}"
        port: 5432

    pgbouncer_max_client_conn: 300
    pgbouncer_max_db_connections: 300
    pgbouncer_max_user_connections: 300

    # govern how many backend connections
    pgbouncer_default_pool_size: 80

    monit_protection: true
    collectd_monitoring: true


Requirements
------------

Module is modified and tested with pgbouncer in greenplum 6.22.x.


Example playbook on ansible control node
----------------

---
$ pwd
/Users/moonja/gpfarmer
$ vi setup-host.yml
- hosts: rk8-master        # Greenplum master hostname
  become: yes
  roles:
    - { role: pgbouncer }


Debugging
---------

If pgbouncer fails to start:-

[gpadmin@rk8-master ~]$ pgbouncer -d /usr/local/greenplum-db/etc/pgbouncer/pgbouncer.ini -vvvv

Testing a connection to a remote database

[gpadmin@rk8-master ~]$ psql -h localhost -p 6432 -U username databasename


Stats
-----

The default 1.7.2 configuration provides peer authentication of the pgbouncer database to show stats.
NOTE: this still requires a userlist.txt entry for the postgres user.

[gpadmin@rk8-master ~]$ psql -p 6432 pgbouncer -c 'show pool;'
[gpadmin@rk8-master ~]$ psql -p 6432 pgbouncer -c 'show stats;'


Reloading / restarting
----------------------

Key config changes such as pool sizing do not require a full restart

$ sysemctl reload pgbouncer


License
-------

LGPL

Author Information
------------------

- Jack Moon, rokmc756@gmail.com
