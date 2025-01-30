## Greenplum Database Arichtecture
![alt text](https://github.com/rokmc756/GPFarmer/blob/main/roles/gpdb/images/greenplum_architecture.webp)

## What is GPFarmer?
GPFarmer is Ansible Playbook to deploy Greenplum Database conveniently on Baremetal, Virtual Machines and Cloud Infrastructure.
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
* GPCC 4x, 6x, 7.x
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
```yaml
$ xcode-select --install
$ brew install ansible
$ brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
```

* Fedora/CentOS/RHEL
```yaml
$ sudo yum install ansible
```

## Prepareing OS
Configure Yum / Local & EPEL Repostiory

## Download / configure / run GPFarmer
#### 1) Clone GPFarmer ansible playbook and go to that directory
```yaml
$ git clone https://github.com/rokmc756/GPFarmer
$ cd GPFarmer
```

#### 2) Configure password for sudo user in VMs where GPDB would be deployed
```yaml
$ vi Makefile
ANSIBLE_HOST_PASS="changeme"  # It should be changed with password of user in ansible host that gpfarmer would be run.
ANSIBLE_TARGET_PASS="changeme"  # # It should be changed with password of sudo user in managed nodes that gpdb would be installed.
```

#### 3) Configure inventory for hostname, ip address, username and user's password
```yaml
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"
remote_machine_password="changeme"


[master]
rk9-node01 ansible_ssh_host=192.168.2.191


[standby]
rk9-node02 ansible_ssh_host=192.168.2.192


[segments]
rk9-node03 ansible_ssh_host=192.168.2.193
rk9-node04 ansible_ssh_host=192.168.2.194
rk9-node05 ansible_ssh_host=192.168.2.195
```

#### 4) Deploy Greenplum MPP Database Cluster
```yaml
$ make gpdb r=install s=db
```

#### 5) Deploy Greenplum Command Center
```yaml
$ make gpcc r=install s=all
```

#### 6) Deploy Greenplum Text
```yaml
$ make gptext r=install
```

#### 7) Deploy MADLib
```yaml
$ make madlib r=install
```

#### 8) Deploy PostGIS
```yaml
$ make postgis r=install
```

## Planning
- [x] Need to fix installing postgis that error, stderr='warning: Unable to get systemd shutdown inhibition lock: Permission denied
- [x] Change CentOS and Rocky Linux repository into local mirror in Korea\
- [x] Converting Makefile.init from original project\
- [x] Adding GPCR role\
- [x] Adding SELinux role\
- [x] Adding tuned role\
- [x] Adding gpupgrade

