# https://access.redhat.com/solutions/5407

# ps aux | awk '{if($1 ~ "weblogic"){Total+=$6}} END {print Total/1024" MB"}'
# 7604.53 MB`

# https://access.redhat.com/solutions/427733

# This can be done by parsing the values /proc/<PID>/smaps as follows:
# cat /proc/<PID>/smaps | grep -i Swap | awk '{sum+=$2} END {print sum}'
# <Sum of memory swapped out>

# cat /proc/8883/smaps | grep -i RSS | awk '{sum+=$2} END {print sum}'
#  <Sum of memory in RAM>
#This can also be extracted from /proc/<PID>/status as follows:

# cat /proc/<PID>/status | egrep "Vm(RSS|Swap)"


# [1] From client on first terminal
# psql -h mdw -p 5432
# create table test_table(a int);
# insert into test_table values (generate_series(1,100000000));
#
#
# [2] From other client on second terminal
# Select the data from the table you created and reboot the client host to simulate the network communication failure.
# nohup psql -h mdw -U gpadmin -p 5432 -c "select * from test_table" &
# nohup: ignoring input and appending output to ‘nohup.out’
# sleep 5; reboot

# create table month_table2 (a int, b date, c varchar(10));
# select count(*) from month_table2 ;
# 232285500

# [ What Support team has done ]
# I’ve tried to reproduce this issue with the following query in same GPDB and GPCC version. However it’s quite hard to see similar result with customer’s one since there were some out of memory issue in psql command and select query quickly was disappeared.

# create table test_table(a int) distributed by (a);
# insert into test_table values (generate_series(1,100000000));
# select * from test_table limit 10000000;

# select * from session_state.session_level_memory_consumption where sess_id = 38;
# select SUM(vmem_mb) from session_state.session_level_memory_consumption where sess_id = 38;

# $ ps -o pid,rss,vsz -p 24124
# PID   RSS    VSZ
# 24124 14184 534664

# gpadmin@rh7-mdw ~]$ vi calmem.sh
# TOTAL_SUM_RSS_VMEM=0
# for pid in `ps aux | grep postgres | grep INSERT | grep -v grep | awk '{print $2}'`
# do
#
#	SUM_RSS_VMEM=`cat /proc/$pid/status | egrep "Vm(RSS|Swap)" | awk '{SUM+=$2} END{print SUM}'`
#	TOTAL_SUM_RSS_VMEM=$(( $TOTAL_SUM_RSS_VMEM + $SUM_RSS_VMEM ))
#	SUM_RSS_VME=0

# done
# echo "$(( $TOTAL_SUM_RSS_VMEM / 1024 )) MB"


# [gpadmin@rh7-mdw ~]$ chmod 755 calmem.sh
# [gpadmin@rh7-mdw ~]$ scp calmem.sh gpadmin@rh7-smdw:/home/gpadmin/
# [gpadmin@rh7-mdw ~]$ scp calmem.sh gpadmin@rh7-node01:/home/gpadmin/
# [gpadmin@rh7-mdw ~]$ scp calmem.sh gpadmin@rh7-node02:/home/gpadmin/
# [gpadmin@rh7-mdw ~]$ scp calmem.sh gpadmin@rh7-node02:/home/gpadmin/

# Run insert query on other terminal

# Check size of memory consumed by postgres
# [gpadmin@rh7-mdw ~]$ gpssh -f hostfile -e "sh /home/gpadmin/calmem.sh"
# [ rh7-smdw] sh /home/gpadmin/calmem.sh
# [ rh7-smdw] 0 MB
# [rh7-mdw] sh /home/gpadmin/calmem.sh
# [rh7-mdw] 24 MB
# [rh7-node01] sh /home/gpadmin/calmem.sh
# [rh7-node01] 511 MB
# [rh7-node03] sh /home/gpadmin/calmem.sh
# [rh7-node03] 507 MB
# [rh7-node02] sh /home/gpadmin/calmem.sh
## [rh7-node02] 500 MB
