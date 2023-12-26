#!/bin/bash

# HOSTS_RANGE="51 55"
# HOSTS_RANGE="61 65"
# HOSTS_RANGE="171 175"
# HOSTS_RANGE="71 75"
HOSTS_RANGE="81 85"
# HOSTS_RANGE="51 55"

NETWORK_RANGE="192.168.0"
USER="root"

for i in `seq $HOSTS_RANGE`
do
    ssh $USER@$NETWORK_RANGE.$i "
        killall postgres python > /dev/null 2>&1;
        rpm -e greenplum-db --allmatches > /dev/null 2>&1;
        rpm -e --allmatches greenplum-db-5 > /dev/null 2>&1;
        rpm -e --allmatches greenplum-db-6 > /dev/null 2>&1;
        rpm -e --allmatches greenplum-db-7 > /dev/null 2>&1;
        dpkg -r greenplum-db-6 > /dev/null 2>&1;
        rm -rf /home/gpadmin/greenplum*.zip /home/gpadmin/greenplum*.rpm /data/master/* /data/primary/* /data/mirror/* \
        /usr/local/greenplum-db /usr/local/greenplum-db-4.* /usr/local/greenplum-db-5.* /usr/local/greenplum-db-7.* /usr/local/greenplum-db-6.* /tmp/.s.PGSQL.* \
        /data/master/gpsne-1 /data/primary/gpsne{0..9} /data/mirror/gpsne{0..9} /data/master/gpsne-1 /data/primary/gpsne{0..9} /data/mirror/gpsne{0..9};
        killall postgres python > /dev/null 2>&1;
        rm -f /etc/cgconfig.d/gpdb.conf;
        echo "" > /etc/sysctl.conf;
        rm -f /etc/sysctl.d/99-sysctl.conf
        systemctl stop cgconfig;
        systemctl disable cgconfig;
        rm -rf /home/gpadmin/.ssh;
        rm -rf /home/gpadmin/*;
        userdel gpadmin
        rm -rf /home/gpadmin;
        rm -f /etc/cgconfig.conf;
        rm -rf /root/.ssh
        "
done
