## What is GPSS role?
It's ansible playbook to deploy Greenplum Streaming Server into Greenplum Database and with Kafka Cluster.\
This role include several sample examples with mock data to interact with Kafka Cluster.

## Where is GPSS role from and how is it changed?
It's originated by itself

## Supported GPSS and extension versions
* GPDB 6.x, 7.x
* GPSS 1.x

## Supported Platform and OS
* Virtual Machines
* Baremetal
* RHEL / CentOS / Rocky Linux 7.x,8.x
* Ubuntu 18.04

## Deploy and Destroy GPSS onto GPDB and Kafka Cluster
#### 1) Configure inventory for hostname, ip address, username and user's password
```
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"              # Replace with sudo username
remote_machine_password="changeme"            # Replace with password of sudo user

[master]
rh8-master  ansible_ssh_host=192.168.0.51    # Change IP address of gpdb master host

[standby]
rh8-slave   ansible_ssh_host=192.168.0.52    # Change IP address of gpdb standby host

[segments]
rh8-node01  ansible_ssh_host=192.168.0.53    # Change IP address of gpdb segment host
rh8-node02  ansible_ssh_host=192.168.0.54    # Change IP address of gpdb segment host
rh8-node03  ansible_ssh_host=192.168.0.55    # Change IP address of gpdb segment host

[kafka_brokers]
rk8-node01 ansible_ssh_host=192.168.0.83
rk8-node02 ansible_ssh_host=192.168.0.84
rk8-node03 ansible_ssh_host=192.168.0.85
```

#### 2) Configure variables to initialize GPDB Hosts with root / gpadmin user and password having wheel group
```
$ vi roles/init-hosts/vars/main.yml
ansible_ssh_pass: "changeme"
ansible_become_pass: "changeme"
sudo_user: "gpadmin"
sudo_group: "gpadmin"
local_sudo_user: "moonja"
wheel_group: "wheel"     # RHEL / CentOS / Rocky
# wheel_group: "sudo"    # Debian / Ubuntu
root_user_pass: "changeme"
sudo_user_pass: "changeme"
sudo_user_home_dir: "/home/{{ sudo_user }}"
domain_name: "jtest.pivotal.io"
```

#### 3) Initialize GPDB and Kafka Hosts with exchanging ssh-key and adding default users as well as installing neccessary packages
```
$ vi install-hosts.yml
- hosts: all
  become: true
  gather_facts: true
  roles:
    - { role: init-hosts }

$ make install
```

#### 4) Configure variables for GPSS with versions, gpss and kafka base directory and so on
```
$ vi roles/gpss/vars/main.yml
---
gpdb_base_dir: "/usr/local"
gpadmin_home_dir: "/home/gpadmin"
gpss_major_version: 1
gpss_minor_version: 10.4
gpss_patch_version:
gpss_gpdb_version: gpdb7
gpss_os_version_kafka: rhel8
gpss_os_version_gpdb: rhel8
gpss_arch_type: x86_64
gpss_database_name: testdb
gpss_mdw_hostname: "{{ hostvars[groups['master'][0]].ansible_hostname }}"
gpss_setup_action: "{{ setup_action }}"
gpss_base_dir: /home/gpadmin/gpss-base
gpss_log_dir: /home/gpadmin/gpss-base/logs
gpss_install_tar: false
kafka_base_dir: /home/gpadmin/kafka-base
~~ snip
```

#### 5) Configure GPSS ansible playbook and deploy GPSS and Kafka extentions
```
$ vi uninstall-hosts.yml
- hosts: all
  become: true
  gather_facts: true
  roles:
    - { role: gpss }

$ make install
```

#### 6) Configure GPSS ansible playbook and destroy GPSS and Kafka extentions
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
