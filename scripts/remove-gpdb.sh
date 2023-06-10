#!/bin/bash
#
# HOSTS_RANGE="51 55"
# HOSTS_RANGE="41 45"
# NETWORK_RANGE="192.168.56"

# HOSTS_RANGE="181 185"
# HOSTS_RANGE="171 175"
# HOSTS_RANGE="171 175"
# NETWORK_RANGE="192.168.56"

# HOSTS_RANGE="81 85"
# HOSTS_RANGE="61 65"
HOSTS_RANGE="41 45"
NETWORK_RANGE="192.168.0"
USER="root"

for i in `seq $HOSTS_RANGE`
do
    ssh $USER@$NETWORK_RANGE.$i "
        killall postgres python;
        rpm -e greenplum-db --allmatches;
        rpm -e --allmatches greenplum-db-5;
        rpm -e --allmatches greenplum-db-6;
        rpm -e --allmatches greenplum-db-7;
        dpkg -r greenplum-db-6;
        rm -rf /home/gpadmin/greenplum*.zip /home/gpadmin/greenplum*.rpm /data/master/* /data/primary/* /data/mirror/* \
        /usr/local/greenplum-db /usr/local/greenplum-db-4.* /usr/local/greenplum-db-5.* /usr/local/greenplum-db-6.* /tmp/.s.PGSQL.* \
        /data/master/gpsne-1 /data/primary/gpsne{0..9} /data/mirror/gpsne{0..9} /data/master/gpsne-1 /data/primary/gpsne{0..9} /data/mirror/gpsne{0..9};
        killall postgres python;
        systemctl stop cgconfig;
        systemctl disable cgconfig;
        rm -f /etc/cgconfig.conf;
        rm -f /etc/cgconfig.d/gpdb.conf;
        ls -al /home/gpadmin/greenplum* /root/.ssh /home/gpadmin/.ssh /data/ /data/master/* /data/primary/* /data/mirror/* \
        /usr/local/greenplum-db /usr/local/greenplum-db-4.* /usr/local/greenplum-db-5.* /usr/local/greenplum-db-6.* /tmp/.s.PGSQL.* \
        /tmp/.s.PGSQL.* /data/master/gpseg-1 /data/primary/gpseg{0..9} /data/mirror/gpseg{0..9};
        ps -ef | grep postgres;"
done
