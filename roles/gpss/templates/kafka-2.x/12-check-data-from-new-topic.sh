/usr/local/kafka/bin/kafka-console-consumer.sh --bootstrap-server {{ kafka.broker_hosts  }} --topic customer_orders --from-beginning
