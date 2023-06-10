#!/bin/bash 
echo "Kerberos: This script leverages a KDC server that is deployed in GSS Lab 30. The script will run the necessary commands on KDC server and will import the keytab file to private datalab. It will run through some setup on the master, but misses out on some configurations. This simulates a case where a customer gets stuck when trying to do this type of setup. Tested on 6.x.

Prerequisite: Need to give sudo access to gpadmin user for the script to work
echo ""gpadmin ALL=(ALL) NOPASSWD:ALL"" | sudo tee /etc/sudoers.d/gpadmin"

echo "What is your name?" 
read name
sudo yum -y install krb5-libs krb5-workstation sshpass  
echo '10.213.47.21 gpdb-kdc.server.com gpdb-kdc' | sudo tee -a /etc/hosts  
host=$(hostname) 
sshcommand="kadmin.local -q \"addprinc -randkey postgres/\"$host\"@GPDB.SERVER.COM\"" 
sshcommand2="kadmin.local -q \"ktadd -k gpdb-kerberos.keytab.\"$name\" postgres/\"$host\"@GPDB.SERVER.COM gpadmin/admin@GPDB.SERVER.COM\"" 
sshpass -p "changeme" ssh -tt -o StrictHostKeyChecking=no root@gpdb-kdc "$sshcommand" 
sshpass -p "changeme" ssh -tt -o StrictHostKeyChecking=no root@gpdb-kdc "$sshcommand2" 
  
bash -c "sshpass -p \"changeme\" scp root@gpdb-kdc:/root/gpdb-kerberos.keytab."$name" /tmp" 
bash -c "sudo cp -r /tmp/gpdb-kerberos.keytab."$name" /home/gpadmin" 
bash -c "sudo chown gpadmin:gpadmin /home/gpadmin/gpdb-kerberos.keytab."$name"" 
bash -c "chmod 400 /home/gpadmin/gpdb-kerberos.keytab."$name"" 
bash -c "gpconfig -c krb_server_keyfile -v  '/home/gpadmin/gpdb-kerberos.keytab."$name"'" 
gpstop -afr 
echo "" 
echo "#################################################################################################################################" 
echo "A DBA attempted to setup Greenplum to use Kerberos using these steps: https://gpdb.docs.pivotal.io/6-17/admin_guide/kerberos.html" 
echo "KDC Server: gpdb-kdc - 10.213.47.21 - root/changeme - VPN is required" 
echo "However, there were a few steps missed and the following command is failing when trying to create the kerberos ticket cache" 
echo "#################################################################################################################################" 
echo "" 
echo "LD_LIBRARY_PATH= kinit -k -t /home/gpadmin/gpdb-kerberos.keytab."$name" gpadmin/admin@GPDB.SERVER.COM" 
bash -c "LD_LIBRARY_PATH= kinit -k -t /home/gpadmin/gpdb-kerberos.keytab."$name" gpadmin/admin@GPDB.SERVER.COM" 
echo "" 
echo "HINT: If you need to find out more about a kerberos command, you can pre-pend KRB5_TRACE=/dev/stdout to the command. Also you should not need to modify anything on the KDC server." 
echo "This is considered solved if you can login with this command:"  
echo "psql -U \"gpadmin/admin\" -h "$host" postgres" 

