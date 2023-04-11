/usr/local/kafka/bin/kafka-console-producer.sh \
--broker-list co7-node01:9092 --topic topic-json-gpkafka < sample_data.json
# --broker-list co7-node01:9092,co7-node02:9092,co7-node03:9092 --topic topic-json-gpkafka < sample_data.csv

