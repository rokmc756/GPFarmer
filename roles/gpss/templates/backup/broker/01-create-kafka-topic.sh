# /usr/local/kafka/bin/kafka-topics.sh --create --bootstrap-server co7-node01:9092,co7-node02:9092,co7-node03:9092 \
/usr/local/kafka/bin/kafka-topics.sh --create --bootstrap-server co7-node01:9092 \
--replication-factor 1 --partitions 1 --topic topic-json-gpkafka
