#!/bin/bash
#
# MASTER_HOST=171
# HOSTS_RANGE="171 172 173 174 175"

# MASTER_HOST="71"
# HOSTS_RANGE="71 75"

MASTER_HOST="81"
HOSTS_RANGE="81 85"
NETWORK_RANGE="192.168.56"

#MASTER_HOST="61"
#HOSTS_RANGE="61 65"

ROOT_USER=root

#
MASTER_HOST_IP=$NETWORK_RANGE.$MASTER_HOST

# ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && source /usr/local/greenplum-cc/gpcc_path.sh && gpcc stop;"
# ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && source /usr/local/greenplum-cc/gpcc_path.sh && gppkg -r MetricsCollector;"

for i in `seq $HOSTS_RANGE`
do
    ssh $ROOT_USER@$NETWORK_RANGE.$i "killall ccagent"
    ssh $ROOT_USER@$NETWORK_RANGE.$i "killall gpccws"
    echo "ssh $ROOT_USER@$NETWORK_RANGE.$i 'rm -rf /usr/local/greenplum-cc* /home/gpadmin/.pgpass /home/gpadmin/certs'"
    ssh $ROOT_USER@$NETWORK_RANGE.$i 'rm -rf /usr/local/greenplum-cc* /home/gpadmin/.pgpass /home/gpadmin/certs'
done

ssh $ROOT_USER@$MASTER_HOST_IP "rm -rf $MASTER_DATA_DIRECTORY/gpperfmon/data/* $MASTER_DATA_DIRECTORY/gpperfmon/logs/* /home/gpadmin/.pgpass"

# ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && psql template1 -c 'DROP ROLE gpmon'"
# ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && psql template1 -c 'gpconfig -c gp_enable_gpperfmon -v off'"
# ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && gpstop -ra"
ssh $ROOT_USER@$MASTER_HOST_IP "rm -rf $MASTER_DATA_DIRECTORY/gpperfmon/data/* $MASTER_DATA_DIRECTORY/gpperfmon/logs/* /home/gpadmin/.pgpass"

# ssh gpadmin@$MASTER_HOST_IP "source /usr/local/greenplum-db/greenplum_path.sh && dropdb gpperfmon"
