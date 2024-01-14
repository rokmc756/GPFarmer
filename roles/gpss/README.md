## Greenplum Streaming Server Architecture
![alt text](https://github.com/rokmc756/GPFarmer/blob/main/roles/gpss/images/greenplum_streaming_server_architecture.png)

## What is GPSS?
The Greenplum Streaming Server (GPSS) is an ETL (extract, transform, load) tool. An instance of the GPSS server ingests streaming data from one or more clients, using Greenplum Database readable external tables to transform and insert the data into a target Greenplum table. The data source and the format of the data are specific to the client. You may also unload data from Greenplum Database to a file using writable external tables.

## How this ansible playbook work?

## Supported GPDB and extension version
* GPDB 6.x, 7.x
* GPSS 1.6.x and higher versions

## Supported Platform and OS
* Virtual Machines
* Baremetal
* RHEL / CentOS / Rocky Linux 6.x,7.x,8.x,9.x
* Ubuntu 18.04

## Prerequisite
MacOS or Fedora/CentOS/RHEL should have installed ansible as ansible host.
Supported OS for ansible target host should be prepared with package repository configured such as yum, dnf and apt

## Prepareing GPDB

## Download / configure / run GPFarmer
#### 1) Clone GPFarmer ansible playbook and go to that directory
```
$ git clone https://github.com/rokmc756/GPFarmer
$ cd GPFarmer
```

#### 2) Configure password for sudo user in VMs where GPDB would be deployed
```
$ vi Makefile
ANSIBLE_HOST_PASS="changeme"   # It should be changed with password of user in ansible host that gpfarmer would be run.
ANSIBLE_TARGET_PASS="changeme" # # It should be changed with password of sudo user in managed nodes that gpdb would be installed.
```

#### 3) Configure inventory for hostname, ip address, username and user's password
```
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"
remote_machine_password="changeme"

[master]
rk8-master ansible_ssh_host=192.168.0.81

[standby]
rk8-slave ansible_ssh_host=192.168.0.82

[segments]
rk8-node01 ansible_ssh_host=192.168.0.83
rk8-node02 ansible_ssh_host=192.168.0.84
rk8-node03 ansible_ssh_host=192.168.0.85

[kafka_brokers]
rh9-node01 ansible_ssh_host=192.168.0.193
rh9-node02 ansible_ssh_host=192.168.0.194
rh9-node03 ansible_ssh_host=192.168.0.195
```

#### 4) Configure variables for GPSS
```
$ vi role/gpss/var/main.yml



```

#### 9) Initialize hosts before deploying GPSS
```
$ vi install-host.yml
---
- hosts: all
  become: true
  roles:
   - { role: init-hosts }

$
- hosts: all
  become: true
  become_user: gpadmin
  roles:
    - { role: gpss }

$ make install
```

#### XXXXXXXXXXXXXXXXX

```
```


## XXXXX
