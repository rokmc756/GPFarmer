#!/bin/bash
#
# RANGE="81 85"
# RANGE="51 55"
# RANGE="41 45"
RANGE="61 65"
# RANGE="171 175"
# RANGE="181 185"
USER="gpadmin"

for i in `seq $RANGE`
do
    # ssh $USER@192.168.56.$i "
    ssh $USER@192.168.0.$i "
    sudo rpm -e greenplum-db --allmatches; sudo rpm -e --allmatches greenplum-db-5; sudo rpm -e --allmatches greenplum-db-6; sudo rpm -e --allmatches greenplum-db-7; sudo rm -rf /home/gpadmin/greenplum*.zip /home/gpadmin/greenplum*.rpm /data/master/* /data/primary/* /data/mirror/* \
    /usr/local/greenplum-db /usr/local/greenplum-db-4.* /usr/local/greenplum-db-5.* /usr/local/greenplum-db-6.* /tmp/.s.PGSQL.* \
    /data/master/gpsne-1 /data/primary/gpsne{0..9} /data/mirror/gpsne{0..9}
    /data/master/gpsne-1 /data/primary/gpsne{0..9} /data/mirror/gpsne{0..9};
    sudo killall postgres python;
    sudo systemctl stop cgconfig;
    sudo systemctl disable cgconfig;
    sudo rm -f /etc/cgconfig.conf;
    sudo rm -f /etc/cgconfig.d/gpdb.conf;
    ls -al /home/gpadmin/greenplum* /root/.ssh /home/gpadmin/.ssh /data/ /data/master/* /data/primary/* /data/mirror/* \
    /usr/local/greenplum-db /usr/local/greenplum-db-4.* /usr/local/greenplum-db-5.* /usr/local/greenplum-db-6.* /tmp/.s.PGSQL.* \
    /tmp/.s.PGSQL.* /data/master/gpseg-1 /data/primary/gpseg{0..9} /data/mirror/gpseg{0..9};
    ps -ef | grep postgres;
    "
done
