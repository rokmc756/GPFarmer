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
        "MASTER") su gpadmin -c "mv /data/master/gpseg-1/recovery.conf /data/master/gpseg-1/recovery.done"
                  su gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && export PGPORT=5432 && gpactivatestandby -a -f -d /data/master/gpseg-1"
                  su gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && gpinitstandby -a -s rk8-master"
                  exit 0
                  ;;
        "BACKUP") su gpadmin -c "mv /data/master/gpseg-1/recovery.done /data/master/gpseg-1/recovery.conf"
                  su gpadmin -c "mv /data/master/gpseg-1 /data/master/gpseg-1_bk_$(date +%Y-%m-%d_%H-%M)"
                  exit 0
                  ;;
        "FAULT") su gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && echo test"
                  exit 0
                  ;;
        *)        echo "Unknown state"
                  exit 1
                  ;;
esac
