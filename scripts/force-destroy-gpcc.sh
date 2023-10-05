#!/bin/bash
#

# MASTER_HOST=171
# HOSTS_RANGE="171 172 173 174 175"

MASTER_HOST="71"
HOSTS_RANGE="71 75"

#
MASTER_HOST_IP=192.168.0.$MASTER_HOST

ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && source /usr/local/greenplum-cc/gpcc_path.sh && gpcc stop;"
ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && source /usr/local/greenplum-cc/gpcc_path.sh && gppkg -r MetricsCollector;"

for i in $HOSTS_RANGE
do
    ssh gpadmin@192.168.0.$i "rm -rf /usr/local/greenplum-cc* /usr/local/greenplum-solr /home/gpadmin/.pgpass /home/gpadmin/certs"
done


ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && psql template1 -c 'DROP ROLE gpmon'"
ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && psql template1 -c 'gpconfig -c gp_enable_gpperfmon -v off'"
ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && gpstop -ra"
ssh gpadmin@$MASTER_HOST_IP "rm -rf $MASTER_DATA_DIRECTORY/gpperfmon/data/* $MASTER_DATA_DIRECTORY/gpperfmon/logs/* /home/gpadmin/.pgpass"
ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && dropdb gpperfmon"

