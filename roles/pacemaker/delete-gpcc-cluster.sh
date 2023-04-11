#
pcs resource delete gpcc
pcs resource delete gpdb-vip
pcs resource delete gpdb

pcs cluster disable --all

kill -9 $(pidof pacemakerd)
pcs cluster stop --all

pcs cluster destroy

exit

# Add a new resource for the gpcc webserver


pcs cluster stop rk8-master

# Disable STONITH with the following pcs command.
pcs property set stonith-enabled=false

# Next, for the Quorum policy, ignore it.
pcs property set no-quorum-policy=ignore

# Check the property list and make sure stonith and the quorum policy are disabled.
pcs property list

#
pcs resource create gpdb-vip ocf:heartbeat:IPaddr2 ip=192.168.0.180 cidr_netmask=24 op monitor interval=30s

# Add a new resource for the gpcc webserver
pcs resource create gpcc ocf:heartbeat:gpcc configfile=/usr/local/greenplum-cc/config/app.conf op monitor timeout="10s" interval="10s"

#
pcs status resources

# Step 7 - Add Constraint Rules to the Cluster
# In this step, we will setup High Availability Rules, and will setup resource constraint with the pcs command line interface.
# Set the collation constraint for webserver and virtual_ip resources with score 'INFINITY'. Also, setup the webserver and virtual_ip resources as same on all server nodes.
pcs constraint colocation add gpdb-vip gpcc INFINITY

# Set the 'virtual_ip' and 'webserver' resources always on same node servers.
pcs constraint order gpdb-vip then gpcc

# Next, stop the cluster and then start again.
pcs cluster stop --all
pcs cluster start --all

pcs status resources

pcs status nodes

corosync-cmapctl | grep members

pcs status corosync

pcs status
