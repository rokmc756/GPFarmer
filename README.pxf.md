## What is PXF role?
It's ansible playbook to deploy Patform Extesnsion Framwork into Greenplum Database with NFS Server / Hadoop Cluster / Minio S3 Ojbect Storage / Oracle / MSSQL Database.\
This role includes several sample examples with mock data to interact with them as well.

## Where is PXF role from and how is it changed?
It's originated by itself

## Supported PXF and extension versions
* GPDB 6.x, 7.x
* PXF 5.x and 6.x

## Supported Platform and OS
* Virtual Machines
* Baremetal
* RHEL / CentOS / Rocky Linux 7.x,8.x
* Ubuntu 18.04

## Deploy and Destroy PXF onto GPDB with Hadoop Cluster
#### 1) Configure inventory for hostname, ip address, username and user's password
```
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"
remote_machine_password="changeme"

[master]
rh8-master ansible_ssh_host=192.168.0.51

[standby]
rh8-slave ansible_ssh_host=192.168.0.52

[segments]
rh8-node01 ansible_ssh_host=192.168.0.53
rh8-node02 ansible_ssh_host=192.168.0.54
rh8-node03 ansible_ssh_host=192.168.0.55

[hadoop]
rk8-master ansible_ssh_host=192.168.0.81
rk8-slave  ansible_ssh_host=192.168.0.82
rk8-node01 ansible_ssh_host=192.168.0.83
rk8-node02 ansible_ssh_host=192.168.0.84
rk8-node03 ansible_ssh_host=192.168.0.85

[hdfs-master]
rk8-master ansible_ssh_host=192.168.0.81

[hdfs-slave]
rk8-slave  ansible_ssh_host=192.168.0.82
```

#### 2) Configure variables to initialize GPDB Hosts with root / gpadmin user and password having wheel group
```
$ vi roles/init-hosts/vars/main.yml
ansible_ssh_pass: "changeme"
ansible_become_pass: "changeme"
sudo_user: "gpadmin"
sudo_group: "gpadmin"
local_sudo_user: "moonja"
wheel_group: "wheel"                 # RHEL / CentOS / Rocky
# wheel_group: "sudo"                # Debian / Ubuntu
root_user_pass: "changeme"
sudo_user_pass: "changeme"
sudo_user_home_dir: "/home/{{ sudo_user }}"
domain_name: "jtest.pivotal.io"
```

#### 3) Initialize GPDB and PXF Hosts with exchanging ssh-key and adding default users as well as installing neccessary packages
```
$ vi install-hosts.yml
- hosts: all
  become: true
  gather_facts: true
  roles:
    - { role: init-hosts }

$ make install
```

#### 4) Configure variables for PXF with versions and hadoop base directory and so on
```
$ vi roles/pxf/vars/main.yml
---
# pxf-gp7-6.8.0-2.el8.x86_64.rpm
pxf_major_version: 6
pxf_minor_version: 9.0
pxf_patch_version: 2
pxf_gpdb_version: gp7
pxf_os_version: "el8"
pxf_database_name: pxf_testdb
pxf_mdw_hostname: rh8-master
pxf_username: pxf_user
pxf_setup_action: "{{ setup_action }}"
gpdb_base_dir: "/usr/local"

install_pxf: true

with_nfs_access: false
pxf_base_dir_with_nfs: /home/gpadmin/pxf-nfs-base
nfs_share_dir: /home/gpadmin/nfsshare
nfs_server_ip_addr: 192.168.0.101

with_hadoop_access: true
hadoop_master_hostname: rk8-master
pxf_base_dir_with_hadoop: /home/gpadmin/pxf-hadoop-base

hadoop_version: "3.3.5"
~~ snip
#
with_oracle_access: true
pxf_base_dir_with_oracle: /home/gpadmin/pxf-oracle-base
oracle_dbname: cdb1
oracle_user: oracleuser
oracle_user_pass: changeme

#
with_mssql_access: true
pxf_base_dir_with_mssql: /home/gpadmin/pxf-mssql-base
mssql_dbname: testdb
mssql_user: mssqluser
mssql_user_pass: "Changeme!@#$"

with_minio_access: true
pxf_base_dir_with_minio: /home/gpadmin/pxf-minio-base
s3_access_key: minioadmin
s3_secret_key: changeme
~~ snip
```

#### 5) Configure PXF ansible playbook and deploy PXF with sample data on NFS, Hadoop Cluster, MinIO S3 Storage, MS-SQL and Oracle Database.
```
$ vi install-hosts.yml
- hosts: all
  become: true
  gather_facts: true
  roles:
    - { role: pxf }

$ make install
```

#### 6) Configure PXF ansible playbook and destroy PXF with sample data on NFS, Hadoop Cluster, MinIO S3 Storage, MS-SQL and Oracle Database.
```
$ vi uninstall-hosts.yml
- hosts: all
  become: true
  gather_facts: true
  roles:
    - { role: gpss }

$ make uninstall
```

## Planning
Converting Makefile.init from original project\
