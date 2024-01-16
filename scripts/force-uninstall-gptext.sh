#!/bin/bash

# RANGE="71 75"
# RANGE="51 55"
RANGE="141 145"
MASTER="141"
NETWORK_RANGE="192.168.0"

ssh gpadmin@$NETWORK_RANGE.$MASTER "dropdb gptext_testdb"
ssh gpadmin@$NETWORK_RANGE.$MASTER "rm -rf /home/gpadmin/gptext*"

for i in `seq $RANGE`; do ssh gpadmin@$NETWORK_RANGE.$i sudo killall java ; done
for i in `seq $RANGE`; do ssh gpadmin@$NETWORK_RANGE.$i sudo rm -rf /usr/local/greenplum-solr /usr/local/greenplum-text /usr/local/greenplum-text-3.* /data/master/zoo0 /home/gpadmin/greenplum-text-3.* /home/gpadmin/gptext*  ; done
for i in `seq $RANGE`; do ssh gpadmin@$NETWORK_RANGE.$i sudo ls -al /usr/local/greenplum-solr /usr/local/greenplum-text /usr/local/greenplum-text-3.* /data/master/zoo0 ; done
for i in `seq $RANGE`; do ssh gpadmin@$NETWORK_RANGE.$i "sudo find /data -name '*solr*' -exec sudo rm -rf {} \;" ; done
for i in `seq $RANGE`; do ssh gpadmin@$NETWORK_RANGE.$i "sudo find /data -name gptext.conf -exec sudo rm -rf {} \;" ; done

