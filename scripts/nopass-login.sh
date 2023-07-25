
NETWORK_RANGE="192.168.0"
HOSTS_RANGE="61 67"

for i in `seq $HOSTS_RANGE`
do

    sshpass -p "changeme" ssh-copy-id gpadmin@$NETWORK_RANGE.$i
    sshpass -p "changeme" ssh-copy-id root@$NETWORK_RANGE.$i

done

# -o StrictHostKeyChecking=no paassupport@tanzu-csp-1.tanzu-gss-labs.vmware.com

