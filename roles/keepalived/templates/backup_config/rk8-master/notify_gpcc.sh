#!/bin/bash

TYPE=$1
NAME=$2
STATE=$3

# $1 - INSTANCE
# $2 - INSTANCE NAME
# $3 - MASTER or BACKUP
# $4 is Priority
# Nothing is in from $5 to $9
echo $1 $2 is in $3 state > /var/run/keepalive.$1.$2.state
echo "Priority : $4" >> /var/run/keepalive.$1.$2.state

case $STATE in
        "BACKUP") su gpadmin -c "rsync -a -e ssh gpadmin@rh7-master:/data/master/gpseg-1/gpmetrics/* /data/master/gpseg-1/gpmetrics/"
                  su gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && source /usr/local/greenplum-cc/gpcc_path.sh && gpcc stop"
                  exit 0
                  ;;
        "MASTER") su gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && source /usr/local/greenplum-cc/gpcc_path.sh && gpcc start"
                  exit 0
                  ;;
        "FAULT") su gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && source /usr/local/greenplum-cc/gpcc_path.sh && gpcc stop"
                  exit 0
                  ;;
        *)        echo "Unknown state"
                  exit 1
                  ;;
esac
