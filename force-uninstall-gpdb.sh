#!/bin/bash


HOSTS_RANGE="191 195"      # rh7
NETWORK_RANGE="192.168.2"
USER="root"

root_pass="changeme"


for i in `seq $HOSTS_RANGE`
do
    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no $USER@$NETWORK_RANGE.$i "
        killall postgres python > /dev/null 2>&1;
        rpm -e greenplum-db --allmatches > /dev/null 2>&1;
        rpm -e greenplum-db-6 --allmatches > /dev/null 2>&1;
        rpm -e --allmatches greenplum-db > /dev/null 2>&1;
        rpm -e --allmatches  open-source-greenplum-db-6-6.26.1-1.el7.x86_64 > /dev/null 2>&1;
        rpm -e --allmatches greenplum-disaster-recovery > /dev/null 2>&1;
        dpkg -r greenplum-db-6 > /dev/null 2>&1;
        rm -rf /home/gpadmin/greenplum*.zip /home/gpadmin/greenplum*.rpm /data/master /data/primary /data/mirror /home/gpadmin/gpinitsystem_config \
        /usr/local/greenplumdb* /usr/local/greenplum-db* /tmp/.s.PGSQL.* /data/coordinator /data/master \
        /data/master/gpsne-1 /data/primary/gpsne{0..9} /data/mirror/gpsne{0..9} /data/coordinator /data/master /data/master/gpsne-1 /data/primary/gpsne{0..9} /data/mirror/gpsne{0..9};
        killall postgres python > /dev/null 2>&1;
        rm -f /etc/cgconfig.d/gpdb.conf;
        echo "" > /etc/sysctl.conf;
        rm -f /etc/sysctl.d/99-sysctl.conf
        systemctl stop cgconfig;
        systemctl disable cgconfig;
        rm -f /etc/cgconfig.conf;
        "
done

#       rm -rf /home/gpadmin/.ssh;
#       rm -rf /home/gpadmin/*;
#       rm -rf /home/gpadmin;
#       userdel gpadmin
#        /home/gpadmin/.ssh/known_hosts /root/.ssh/known_hosts \

