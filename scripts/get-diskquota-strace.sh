for i in `ps -ef | grep bgworker | grep diskquota | awk '{print $2}'`
do
	timeout -s 9 5s strace -T -tt -p $i -o strace-pid-$i-diskquota-$(date +%Y-%m-%d-%H-%M).out
done
