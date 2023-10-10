/usr/local/kafka/bin/kafka-console-producer.sh --broker-list {{ kafka_broker_hosts }} --topic customer_orders < ./sample_customer_data.csv
