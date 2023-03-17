# Create hacluster user which can be used together with PCS to do the configuration of the cluster nodes.
echo "changeme" | passwd --stdin hacluster

# Authentication is needed on all nodes before the configuration is allowable to change.
# Use the previously configured hacluster user and password to do this.
pcs host auth rk8-master rk8-slave -u hacluster -p changeme

# Create the cluster and add nodes. Adding/Setting both nodes starts cluster named gpcc-cluster.
pcs cluster setup gpcc-cluster rk8-master rk8-slave --force

pcs cluster auth -u hacluster -p changeme

# After creating the cluster and adding nodes to it, it can be started.
# The cluster wont do a lot yet since any resources have not been configured.
pcs cluster start --all

# To check the status of the cluster after starting it.
# pcs status cluster

# To check the status of the nodes in the cluster.
# pcs status nodes
# corosync-cmapctl | grep members
# pcs status corosync

# Since two node cluster will be deployed, the stonith option should be disabled.
pcs property set stonith-enabled=false

# Configure the quorum settings to ignore a low quorum while configuring the behavior of the cluster.
pcs property set no-quorum-policy=ignore
# pcs property list

# pcs node unstandby rk8-master
# pcs node standby rk8-slave

# A virtual IP will be added to cluster. This virtual IP is the IP address which will be contacted to reach the services (the GPCC in this case). A virtual IP is a resource. To add the resource:
pcs resource create gpdb-vip ocf:heartbeat:IPaddr2 ip=192.168.0.180 cidr_netmask=24 nic=eth0 iflabel=0 op monitor interval=10s on-fail=standby

pcs resource create gpdb ocf:heartbeat:gpdb op monitor timeout=10s interval=10s on-fail=standby

# 
pcs resource create gpcc ocf:heartbeat:gpcc op monitor timeout=10s interval=10s
# on-fail=standby

pcs constraint location gpdb prefers rk8-master=50
pcs constraint location gpdb-vip prefers rk8-master=50
pcs constraint location gpcc prefers rk8-slave=50

pcs constraint colocation add gpdb with gpdb-vip INFINITY
# Set the 'gpcc-vip' and 'gpccr' resources always on same node servers.
pcs constraint order gpdb then gpdb-vip

pcs resource meta gpdb resource-stickiness=0
pcs resource meta gpdb-vip resource-stickiness=0
pcs resource meta gpcc resource-stickiness=0

# pcs resource meta gpcc resource-stickiness=100 - OK for only failover gpcc resource to other

pcs status

#
# pcs resource show gpcc
# pcs constraint location gpcc-vip prefers rk8-master=50
# pcs constraint location gpcc prefers rk8-master=50

# pcs constraint colocation add gpcc-vip with gpcc INFINITY
# Set the 'gpcc-vip' and 'gpccr' resources always on same node servers.
# pcs constraint order gpcc-vip then gpcc

# pcs node standby rk8-master
# pcs node unstandby rk8-slave

# pcs constraint
# pcs cluster stop --all && pcs cluster start --all
# pcs resource cleanup gpcc

# pcs property set default-resource-stickiness="INFINITY"
# pcs resource defaults resource-stickiness=100
# pcs resource defaults update resource-stickiness=100

# pcs resource cleanup gpcc


exit



# 12.3.1. Configuring an "Opt-In" cluster
# To create an opt-in cluster, set the symmetric-cluster cluster property to false to prevent resources
# from running anywhere by default.

# pcs property set symmetric-cluster=false
# Enable nodes for individual resources. The following commands configure location constraints so that
# the resource Webserver prefers node example-1, the resource Database prefers node example-2, and both
# resources can fail over to node example-3 if their preferred node fails. When configuring location 
# constraints for an opt-in cluster, setting a score of zero allows a resource to run on a node without
# indicating any preference to prefer or avoid the node.

# pcs constraint location Webserver prefers example-1=200
# pcs constraint location Webserver prefers example-3=0
# pcs constraint location Database prefers example-2=200
# pcs constraint location Database prefers example-3=0

# To create an opt-out cluster, set the symmetric-cluster cluster property to true to allow resources to
# run everywhere by default. This is the default configuration if symmetric-cluster is not set explicitly.

# pcs property set symmetric-cluster=true
# The following commands will then yield a configuration that is equivalent to the example in "Configuring
# an "Opt-In" cluster". Both resources can fail over to node example-3 if their preferred node fails, since
# every node has an implicit score of 0.

# pcs constraint location Webserver prefers example-1=200
# pcs constraint location Webserver avoids example-2=INFINITY
# pcs constraint location Database avoids example-1=INFINITY
# pcs constraint location Database prefers example-2=200


# Step 7 - Add Constraint Rules to the Cluster
# In this step, we will setup High Availability Rules, and will setup resource constraint with the pcs command
# line interface.
# Set the collation constraint for webserver and virtual_ip resources with score 'INFINITY'. Also, setup the
# webserver and virtual_ip resources as same on all server nodes.
# pcs constraint colocation add gpdb-vip gpcc INFINITY

# Set the 'virtual_ip' and 'webserver' resources always on same node servers.
# pcs constraint order gpdb-vip then gpcc

# Next, stop the cluster and then start again.
# pcs cluster stop --all
# pcs cluster start --all

# pcs status resources
# pcs status nodes
# corosync-cmapctl | grep members
# pcs status corosync
# pcs cluster stop rk8-master
# pcs status

# Prevent Resources from Moving after Recovery
# In most circumstances, it is highly desirable to prevent healthy resources from being moved around the cluster.
# Moving resources almost always requires a period of downtime. For complex services such as databases, this period
#can be quite long.

# To address this, Pacemaker has the concept of resource stickiness, which controls how strongly a service prefers
# to stay running where it is. You may like to think of it as the “cost” of any downtime.
# By default, [1] Pacemaker assumes there is zero cost associated with moving resources and will do so to 
# achieve “optimal” [2] resource placement. We can specify a different stickiness for every resource,
# but it is often sufficient to change the default.

# pcs resource defaults update resource-stickiness=100
# Warning: Defaults do not apply to resources which override them with their own defined values
