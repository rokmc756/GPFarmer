#!/bin/bash

RANGE="61 65"
for i in `seq $RANGE`; do ssh gpadmin@192.168.0.$i sudo killall java ; done
for i in `seq $RANGE`; do ssh gpadmin@192.168.0.$i sudo rm -rf /usr/local/greenplum-solr /usr/local/greenplum-text /usr/local/greenplum-text-3.* /data/master/zoo0 /home/gpadmin/greenplum-text-3.*  ; done
for i in `seq $RANGE`; do ssh gpadmin@192.168.0.$i sudo ls -al /usr/local/greenplum-solr /usr/local/greenplum-text /usr/local/greenplum-text-3.* /data/master/zoo0 ; done
for i in `seq $RANGE`; do ssh gpadmin@192.168.0.$i "sudo find /data -name '*solr*' -exec sudo rm -rf {} \;" ; done
for i in `seq $RANGE`; do ssh gpadmin@192.168.0.$i "sudo find /data -name gptext.conf -exec sudo rm -rf {} \;" ; done
