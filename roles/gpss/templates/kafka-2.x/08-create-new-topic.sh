/usr/local/kafka/bin/kafka-topics.sh --create --zookeeper {{ kafka.zookeeper_hosts }}/gpdb-kafka --replication-factor 1 --partitions 1 --topic customer_orders
