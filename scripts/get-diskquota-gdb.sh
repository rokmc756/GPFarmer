for i in `ps -ef | grep bgworker | grep diskquota | awk '{print $2}'`
do
	gdb -ex 'set confirm off' -ex 'set trace-command on' -ex 'p *active_tables_map' \
        -ex 'p * active_tables_map->hctl' -ex 'quit' -p $i > gdb-pid-$i-diskquota-$(date +%Y-%m-%d-%H-%M).out
done
