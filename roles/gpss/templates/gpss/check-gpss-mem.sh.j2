# psql gpperfmon -c "select ssid,tstart,memory,cpu_master,cpu_segs,peak_memory,query_text  from gpmetrics.gpcc_queries_history where username = 'gpadmin' order by peak_memory desc limit 3;"
# psql gpperfmon -c "select cast(sum(memory)/1024 as int)||' MB' as memory  from gpmetrics.gpcc_queries_history where username = 'gpadmin' limit 3;"
# psql -c "select max(endtime) - min(starttime) as duration from gpkafka_gpss_from_kafka_59adb30a1fe73465dd526311e07b547b ;"
# psql -c "select distinct(version) from gpkafka_gpss_from_kafka_59adb30a1fe73465dd526311e07b547b limit 3;"


echo ""
ps -C gpss -o comm,pid,rss,pmem,vsz,tty,stat,time,command

echo ""
ps -ef | grep INSERT | grep postgres | grep testdb

echo ""
ps -C postgres -o comm,pid,rss,pmem,vsz,tty,stat,time,command
echo ""

#
for pid in $(ps -ef | grep gpss | grep greenplum-db | grep -v grep | awk '{print $2}')
do

    echo "[ pmap ]"
    echo "+---------------------------------------------------------------------------+"
    pmap -XX $pid | head -n +2
    pmap -XX $pid | tail -n -2
    # pmap -x $(ps -ef | grep gpss | grep greenplum-db | grep -v grep | awk '{print $2}') | sed -e '1,2d' | head -n -2 | awk '{sum+=$2} END {print sum}'
    # pmap -x $(ps -ef | grep gpss | grep greenplum-db | grep -v grep | awk '{print $2}') | head -n +2

    echo ""
    echo "+---------------------------------------------------------------------------+"
    echo "[ Sum of anonymous ]"
    pmap -XX $pid | sed -e '1,2d' | head -n -2 | awk '{sum+=$14} END {print sum}'

    echo ""
    echo "[ smap ]"
    echo "+---------------------------------------------------------------------------+"
    cat /proc/$pid/smaps | grep Rss | grep -v grep | awk '{sum+=$2} END {print sum}'
    echo "+---------------------------------------------------------------------------+"

    echo ""
    echo "[ ps output ]"
    echo "+---------------------------------------------------------------------------+"
    ps -C gpss -o comm,pid,rss,pmem,vsz
    echo "+---------------------------------------------------------------------------+"
    # pmap -x $(ps -ef | grep gpss | grep greenplum-db | grep -v grep | awk '{print $2}') | awk '{sum+=$2} END {print sum}'

done

