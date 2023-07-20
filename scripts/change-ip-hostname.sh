#!/bin/bash

_gw_ipaddr="192.168.0.2"
_org_ipaddr="192.168.0.170"

for idx in $(cat ./hostname_conf)
do

    _target_hostname=$(echo $idx | cut -d , -f 1)
    _target_ipaddr=$(echo $idx | cut -d , -f 2)

    # echo "$_target_hostname - $_target_ipaddr"

    ssh root@$_gw_ipaddr "virsh start $_target_hostname"
    sleep 60


    for eth_n in `seq 1 3`
    do
        ssh root@$_org_ipaddr "sed -i -e s/$_org_ipaddr/$_target_ipaddr/g /etc/sysconfig/network-scripts/ifcfg-eth$eth_n"
    done
    
    ssh root@$_org_ipaddr "hostnamectl set-hostname $_target_hostname"
    ssh root@$_org_ipaddr "reboot"

done
