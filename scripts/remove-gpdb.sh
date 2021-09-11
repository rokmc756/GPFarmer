#!/bin/bash

RANGE="61 65"
USER="gpadmin"

for i in `seq $RANGE`
do
    ssh $USER@192.168.0.$i "
    sudo rpm -e greenplum-db --allmatches; sudo rpm -e --allmatches greenplum-db-6; sudo rm -rf /home/gpadmin/greenplum*.zip /home/gpadmin/greenplum*.rpm /data/ /data/master /data/primary /data/mirror \
    /usr/local/greenplum-db /usr/local/greenplum-db-4.* /usr/local/greenplum-db-5.* /usr/local/greenplum-db-6.* /tmp/.s.PGSQL.* \
    /data/master/gpsne-1 /data/primary/gpsne{0..9} /data/mirror/gpsne{0..9} \
    /data/master/gpsne-1 /data/primary/gpsne{0..9} /data/mirror/gpsne{0..9};
    sudo killall postgres python;
    ls -al /home/gpadmin/greenplum* /root/.ssh /home/gpadmin/.ssh /data/ /data/master /data/primary /data/mirror \
    /usr/local/greenplum-db /usr/local/greenplum-db-4.* /usr/local/greenplum-db-5.* /usr/local/greenplum-db-6.* /tmp/.s.PGSQL.* \
    /tmp/.s.PGSQL.* /data/master/gpseg-1 /data/primary/gpseg{0..9} /data/mirror/gpseg{0..9};
    ps -ef | grep postgres;
"
done
#    sudo rpm -e greenplum-db ; sudo rm -rf /home/gpadmin/greenplum* /root/.ssh /home/gpadmin/.ssh /data/ /data/master /data/primary /data/mirror \
