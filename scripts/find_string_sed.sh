for i in `grep -r metrics_collector /data | grep shared_preload_libraries | grep metrics_collector | cut -d : -f 1`
do
	echo $i
	sed -ie 's/metrics_collector//g' $i
done

# gpconfig -c shared_preload_libraries -v ''
