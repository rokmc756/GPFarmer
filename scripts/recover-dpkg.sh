#!/bini/bash   
#
HOSTS_RANGE="41 45"
NETWORK_RANGE="192.168.0"
USER="root"

for i in `seq $HOSTS_RANGE`
do

    ssh $USER@$NETWORK_RANGE.$i "
        killall apt apt-get;
        rm /var/lib/apt/lists/lock;
        rm /var/cache/apt/archives/lock;
        rm /var/lib/dpkg/lock*;
        dpkg --configure -a;
        apt update;
    "
done
