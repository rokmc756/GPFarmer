#!/bin/bash

# Create directory for logs
gpssh -f hostfile_all "mkdir /home/gpadmin/hung-queries"

# List of the running queries:
psql -P pager=off -c "select * from pg_stat_activity;" > /home/gpadmin/hung-queries/pg-stat-activity-$(date +%Y-%m-%d-%H-%M).out

# List of locks on master & all segments:
psql -P pager=off -c "select gp_segment_id, * from pg_locks;" > /home/gpadmin/hung-queries/list-locks-$(date +%Y-%m-%d-%H-%M).out

psql -P pager=off -c "select * from gp_toolkit.gp_locks_on_relation;" > /home/gpadmin/hung-queries/list-rel-locks-$(date +%Y-%m-%d-%H-%M).out

psql -P pager=off -c "select * from gp_toolkit.gp_locks_on_resqueue;" > /home/gpadmin/hung-queries/list-res-locsk--$(date +%Y-%m-%d-%H-%M).out

# Dump current status of resource queues:
psql -P pager=off -c "select * from gp_toolkit.gp_resq_activity;" > /home/gpadmin/hung-queries/rq-activity-$(date +%Y-%m-%d-%H-%M).out
psql -P pager=off -c "select * from gp_toolkit.gp_resqueue_status" > /home/gpadmin/hung-queries/rq-status-$(date +%Y-%m-%d-%H-%M).out

# List of all processes running on all segments:
gpssh -f hostfile_all "mkdir /home/gpadmin/hung-queries"

# List of all processes running on all segments:
gpssh -f hostfile "ps -elfy" > /home/gpadmin/hung-queries/list-all-running-process-seg.out

# List of all postgres processes running on all nodes:
gpssh -f hostfile_all "ps -flyCpostgres" > /home/gpadmin/hung-queries/list-all-process-all.out

# List of all processes for the 'hung' process:
gpssh -f hostfile_all "ps -flyCpostgres | grep conSESS_ID"  > /home/gpadmin/hung-queries/list-all-hung-process.out

# Verify if any of the processes are stuck in IO wait. This may indicate an issues with either the OS or the underlying hardware:
gpssh -f hostfile_all "ps -flyCpostgres | grep conSESS_ID | grep ^D" > /home/gpadmin/hung-queries/verify-stuck-iowait.out

# Finally, list any running processes for the query in question that are running
gpssh -f hostfile_all "ps -flyCpostgres | grep conSESS_ID | grep ^R" > /home/gpadmin/hung-queries/list-all-problematical-queries.out

# The pstack output for all session processes:
gpssh -f hostfile_all "ps -flyCpostgres | grep conSESS_ID | grep -v ^D | awk '{print \$3}' | while read pid; do pstack \$pid > /home/gpadmin/hung-queries/\$(hostname)-pstack-pid.\$pid; done"

# lsof output for all sessions processes:
gpssh -f hostfile_all "ps -flyCpostgres | grep conSESS_ID | grep -v ^D | awk '{print \$3}' | while read pid; do /usr/sbin/lsof -p \$pid > /home/gpadmin/hung-queries/\$(hostname)-lsof-pid.\$pid; done"

# For any process that is running we will need to collect some additional information:
# A core file for each running process:
gpssh -f hostfile_all "ps -flyCpostgres | grep conSESS_ID | grep -v ^D | awk '{print \$3}' | while read pid; do gcore -o /home/gpadmin/hung-queries/\$(hostname)-gcore-pid.\$pid \$pid; done"

# Generate a command file to collect the strace output from each of the running processes:
# gpssh -f hostfile_all "ps -flyCpostgres | grep conSESS_ID | grep ^R | awk '{print \$3}' | xargs -n1 -I '{}' echo '(strace -p {} -o strace -ff )  & sleep 15 ; kill \$!'"

# Generate a command file to collect the strace output from each of the running processes:
gpssh -f hostfile_all "ps -flyCpostgres | grep conSESS_ID | grep ^R | awk '{print \$3}' | xargs -n1 -I '{}' echo '( strace -T -tttt -p {} -o /home/gpadmin/hung-queries/\$(hostname)-strace-pid-{}-\$(date +%Y-%m-%d-%H-%M).out )  & sleep 15 ; kill \$!'"

# Generate a command file to collect the strace output from each of the running processes:
gpssh -f hostfile_all "tar czfp /home/gpadmin/\$(hostname)-get-hung-query-\$(date +%Y-%m-%d-%H-%M).tar.gz /home/gpadmin/hung-queries"

# Gather all
gpssh -f hostfile_all "scp /home/gpadmin/\$(hostname)-get-hung-query-*.tar.gz rh7-master:/home/gpadmin/"

# strace -T -tttt -p 4317 -o strace-pid-4317--$(date +%Y-%m-%d-%H-%M).out
