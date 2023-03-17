#!/bin/bash

MASTER_HOST=61
HOSTS_RANGE="61 62 63 64 65"
# MASTER_HOST=171
# HOSTS_RANGE="171 172 173 174 175"
MASTER_HOST_IP=192.168.0.$MASTER_HOST

ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && source /usr/local/greenplum-cc/gpcc_path.sh && gpcc stop;"
# ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && source /usr/local/greenplum-cc-web/gpcc_path.sh && gpcc stop;"

for i in $HOSTS_RANGE
do
    ssh gpadmin@192.168.0.$i "rm -rf /usr/local/greenplum-cc* /usr/local/greenplum-solr /home/gpadmin/.pgpass /home/gpadmin/certs;"
    ssh gpadmin@192.168.0.$i "ls -al /home/gpadmin/.pgpass;"
done

# su - gpadmin
# gpconfig -c gp_enable_gpperfmon -v off
# Remove or comment out the gpmon entries in pg_hba.conf. For example:

# local     gpperfmon     gpmon     md5
# host      gpperfmon     gpmon    0.0.0.0/0    md5

ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && psql template1 -c 'DROP ROLE gpmon;';"
ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && gpstop -ra;"

ssh gpadmin@$MASTER_HOST_IP "rm -rf $MASTER_DATA_DIRECTORY/gpperfmon/data/* $MASTER_DATA_DIRECTORY/gpperfmon/logs/* /home/gpadmin/.pgpass;"

ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && dropdb gpperfmon;"

