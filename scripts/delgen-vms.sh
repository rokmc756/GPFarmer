#!/bin/bash

_gw_ipaddr="192.168.0.2"
_org_ipaddr="192.168.0.170"

for idx in $(cat ./hostname_conf)
do

    _target_hostname=$(echo $idx | cut -d , -f 1)
    _target_ipaddr=$(echo $idx | cut -d , -f 2)

    echo "ssh root@$_gw_ipaddr 'virsh start $_target_hostname'"
    echo "sleep 60"

    echo "ssh root@$_gw_ipaddr 'virsh shutdown $_target_hostname'"
    echo "sleep 20;"

    echo "ssh root@$_gw_ipaddr 'virsh destroy $_target_hostname'"
    echo "sleep 20"

    echo "ssh root@$_gw_ipaddr 'virsh undefine --domain $target_hostname'"
    echo "sleep 30;"

    echo "ssh root@$_gw_ipaddr 'rm -rf /storage/libvirt-images/$_target_hostname.qcow2'"
    echo "sleep 10;"

    echo "ssh root@$_gw_ipaddr 'virt-clone --original _rocky8-temp --name $_target_hostname --auto-clon"

done
