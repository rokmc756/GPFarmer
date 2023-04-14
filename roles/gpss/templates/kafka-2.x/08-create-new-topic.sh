/usr/local/kafka/bin/kafka-topics.sh --create --zookeeper co7-node01:2181/gpdb-kafka --replication-factor 1 --partitions 1 --topic customer_orders

# /usr/local/kafka/bin/kafka-topics.sh --create --zookeeper co7-node01:2181,co7-node02:2181,co7-node03:2181/gpdb-kafka --replication-factor 1 --partitions 1 --topic customer_orders
