## What is GPFarmer?
GPFarmer is ansible playbook to deploy Greenplum Database conveniently on Baremetal, Virtual Machines and Cloud Infrastructure.
It provide also many extensions to install such GPText, madlib, GPCC, postgis as well. The main purpose of this project is actually
very simple. Because i have many jobs to install different kind of GPDB versions and reproduce issues & test features  as a support
engineer. I just want to spend less time for it.

If you are working with GPDB such as Developer, Administrator, Field Engineer or Data Scientist you could also use it very useful with
saving time.

## Where is GPFarmer from and how is it changed?
GPFarmer has been developing based on gpdb-ansible project - https://github.com/andreasscherbaum/gpdb-ansible. Andreas! Thanks for sharing it.
Since it only provide install GPDB on a single host GPFarmer support multiple hosts and many extensions to deploy them and support two binary type, rpm and bin.

## Supported GPDB and extension version
* GPDB 4.x, 5.x, 6.x, 7.x
* GPCC 4x, 6x
* GPTEXT 3.x.x
* madlib 1.x, 2.x
* postgis 2.x

## Supported Platform and OS
* Virtual Machines
* Baremetal
* RHEL / CentOS / Rocky Linux 5.x,6.x,7.x,8.x,9.x
* Ubuntu 18.04

## Prerequisite
MacOS or Fedora/CentOS/RHEL should have installed ansible as ansible host.
Supported OS for ansible target host should be prepared with package repository configured such as yum, dnf and apt

## Prepare ansible host to run GPFarmer
* MacOS
```
$ xcode-select --install
$ brew install ansible
$ brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
```

* Fedora/CentOS/RHEL
```
$ sudo yum install ansible
```

## Prepareing OS
Configure Yum / Local & EPEL Repostiory

## Download / configure / run GPFarmer
#### 1) Clone GPFarmer ansible playbook and go to that directory
```
$ git clone https://github.com/rokmc756/GPFarmer
$ cd gpfarmer
```

#### 2) Configure password for sudo user in VMs where GPDB would be deployed
```
$ vi Makefile
ANSIBLE_HOST_PASS="changeme"  # It should be changed with password of user in ansible host that gpfarmer would be run.
ANSIBLE_TARGET_PASS="changeme"  # # It should be changed with password of sudo user in managed nodes that gpdb would be installed.
```

#### 3) Configure inventory for hostname, ip address, username and user's password
```
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="gpadmin"             # Replace with username of gpdb administrator
remote_machine_password="changeme"            # Replace with password of user

[master]
rk8-master  ansible_ssh_host=192.168.0.171    # Change IP address of gpdb master host

[standby]
rk8-slave   ansible_ssh_host=192.168.0.172    # Change IP address of gpdb standby host

[segments]
rk8-node01  ansible_ssh_host=192.168.0.173    # Change IP address of gpdb segment host
rk8-node02  ansible_ssh_host=192.168.0.174    # Change IP address of gpdb segment host
rk8-node03  ansible_ssh_host=192.168.0.175    # Change IP address of gpdb segment host
```

#### 4) Configure variables for GPDB
```
$ vi role/gpdb/var/main.yml
---
# number of Greenplum Database segments
local_machine_user: "moonja"
gpdb_number_segments: 4
gpdb_mirror_enable: true
gpdb_spread_mirrors: ""

gpdb_major_version: 6
gpdb_minor_version: 23
gpdb_build_version: 0
gpdb_os_name: 'rhel8'
gpdb_arch_name: 'x86_64'
gpdb_binary_type: 'rpm'
~~ snip
```

#### 5) Configure variables for GPText
```
$ vi role/gpcc/var/main.yml
---
gpdb_major_version: 6
gpdb_minor_version: 23.0
gpdb_build_version:
gpcc_major_version: 6
gpcc_minor_version: 8.4

gpdb_metric_major_version: 6
gpdb_metric_minor_version: 23.0
gpdb_metric_build_version:
gpcc_metric_arch: 'x86_64'
gpcc_os_name: 'rhel8'

gpccws_port: 28080
gpmon_password: "changeme"
master_data_dir: "/data/master/gpseg-1"
~~ snip
```

#### 6) Configure variables for GPText
```
$ vi role/gptext/var/main.yml
---
# greenplum-text-3.3.1-rhel7_x86_64.tar.gz
# greenplum-text-3.9.1-rhel8_x86_64.tar.gz
gptext_major_version: 3
gptext_minor_version: 9.1
gptext_patch_version:
gptext_build_version:
gptext_gpdb_version:
gptext_java_version: 1.8.0
gptext_rhel_name: rhel8
gptext_database_name: gptext_testdb
gptext_all_hosts: "rk8-master rk8-slave rk8-node01 rk8-node02 rk8-node03"
```

#### 7) Configure variables for MADLib
```
$ vi role/madlib/var/main.yml
---
madlib_prefix_major_version:
madlib_major_version: 1
madlib_minor_version: 21
madlib_patch_version: 0
madlib_build_version: 1
madlib_gpdb_version: 6
madlib_os_version: rhel8
madlib_arch_type: x86_64
madlib_database_name: madlib_testdb
madlib_mdw_hostname: rk8-master
~~ snip
```

#### 8) Configure variables for PostGIS
```
$ vi role/postgis/var/mail.yml
---
postgis_prefix_major_version:
postgis_major_version: 2
postgis_minor_version: 5
postgis_patch_version: .4+pivotal.8.build.1
postgis_gpdb_version: 6
postgis_os_version: rhel8
postgis_database_name: postgis_testdb
postgis_schema_name: postgis_test_scheme
postgis_mdw_hostname: rk8-master
```

#### 9) Configure order of roles in GPFarmer anisble playbook and deploy GPDB and extentions
```
$ vi setup-host.yml
---
- hosts: all
  become: true
  roles:
   - { role: init-hosts }
   - { role: gpdb }
   - { role: madlib }
   - { role: postgis }
   - { role: pljava }
   - { role: plcontainer }
   - { role: DataSciencePython }
   - { role: DataScienceR }
   - { role: pxf }
   - { role: gptext }
   - { role: plr }

- hosts: rk8-master,rk8-slave
  become: true
  become_user: gpadmin
  roles:
    - { role: gpcc }

$ make install
```

#### 10) Configure order of roles in GPFarmer anisble playbook and destroy GPDB and extentions
```
$ vi uninstall-host.yml
---
- hosts: rk8-master,rk8-slave
  become: true
  become_user: gpadmin
  roles:
    - { role: gpcc }

- hosts: all
  become: true
  roles:
   - { role: plr }
   - { role: gptext }
   - { role: pxf }
   - { role: DataScienceR }
   - { role: DataSciencePython }
   - { role: plcontainer }
   - { role: pljava }
   - { role: postgis }
   - { role: madlib }
   - { role: gpdb }
   - { role: init-hosts }

$ make uninstall
```

## Planning
Converting Makefile.init from original project\
Adding GPCR role\
Adding SELinux role\
Adding tuned role\
Adding gpupgrade
