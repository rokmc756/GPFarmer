/usr/local/kafka/bin/kafka-topics.sh --zookeeper {{ kafka.zookeeper_hosts }}/gpdb-kafka \
--topic customer_orders --delete
