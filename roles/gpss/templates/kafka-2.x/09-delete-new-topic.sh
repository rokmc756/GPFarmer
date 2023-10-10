/usr/local/kafka/bin/kafka-topics.sh --zookeeper {{ zookeeper_hosts }}/gpdb-kafka \
--topic customer_orders --delete
