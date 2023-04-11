for i in `echo "customer_expenses2 json-topic-gpkafka topci-json-gpkafka topic-json-gpkafka"`
do
	# /usr/local/kafka/bin/kafka-topics.sh --bootstrap-server co7-node01:9092,co7-node02:9092,co7-node03:9092 --topic $i --delete
	/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server co7-node01:9092 --topic $i --delete
done
