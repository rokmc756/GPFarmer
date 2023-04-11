# Create hacluster user which can be used together with PCS to do the configuration of the cluster nodes.
echo "changeme" | passwd --stdin hacluster

# Authentication is needed on all nodes before the configuration is allowable to change.
# Use the previously configured hacluster user and password to do this
pcs host auth rk8-master rk8-slave -u hacluster -p changeme

# Create the cluster and add nodes. Adding/Setting both nodes starts cluster named gpcc-cluster.
pcs cluster setup gpcc-cluster rk8-master rk8-slave --force

#
pcs cluster auth -u hacluster -p changeme

# After creating the cluster and adding nodes to it, it can be started.
# The cluster wont do a lot yet since any resources have not been configured.
pcs cluster start --all

# To check the status of the nodes in the cluster.
# pcs status nodes
# corosync-cmapctl | grep members
# pcs status corosync

# Since two node cluster will be deployed, the stonith option should be disabled.
pcs property set stonith-enabled=false

# Configure the quorum settings to ignore a low quorum while configuring the behavior of the cluster.
pcs property set no-quorum-policy=ignore
# pcs property list

#pcs node unstandby rk8-master
#pcs node standby rk8-slave

# Then set the migration-threshold for the resource if you want a lower number than the defaults.
# pcs property set start-failure-is-fatal=false

# A virtual IP will be added to cluster. This virtual IP is the IP address which will be contacted to reach the services (the GPCC in this case). A virtual IP is a resource. To add the resource:
pcs resource create gpdb-vip ocf:heartbeat:IPaddr2 ip=192.168.0.180 cidr_netmask=24 nic=eth0 iflabel=0 op monitor interval=60s \
on-fail=standby

pcs resource create gpdb ocf:heartbeat:gpdb op monitor interval=60s \
on-fail=standby
# pcs resource create gpdb ocf:heartbeat:gpdb op monitor timeout=30s interval=10s on-fail=standby role="Promoted" promotable

pcs constraint location gpdb prefers rk8-master=50
pcs constraint location gpdb-vip prefers rk8-master=50

# pcs constraint colocation add gpdb with gpdb-vip INFINITY
pcs constraint colocation add gpdb with gpdb-vip INFINITY

# Set the 'gpcc-vip' and 'gpccr' resources always on same node servers.
# pcs constraint order gpdb then gpdb-vip
pcs constraint order gpdb then gpdb-vip

# pcs resource meta gpdb migration-threshold=4
# pcs resource meta gpdb-vip migration-threshold=4

pcs resource meta gpdb resource-stickiness=0
pcs resource meta gpdb-vip resource-stickiness=0

# By default, the property start-failure-is-fatal is set to true. When this property is set to true, a start operation failure causes the fail count to be set to INFINITY. This prevents the resource from attempting to start on that same node again until the failure is cleaned up. It will then try to start on another eligible node, if one exists.
# If the start-failure-is-fatal property has been set to false, then the start operation will behave like the monitor operation: if it fails, it will stop and retry until the migration-threshold is reached. The migration-threshold meta attribute is set to 1000000 by default but can be overridden. (1000000 is Pacemaker's numeric representation of the macro INFINITY.)

sleep 30

pcs resource create gpcc ocf:heartbeat:gpcc op monitor timeout=60s interval=10s
pcs constraint location gpcc prefers rk8-slave=50
pcs resource meta gpcc resource-stickiness=0

pcs status
