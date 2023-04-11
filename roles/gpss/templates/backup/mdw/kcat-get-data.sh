# yum install -y kcat
# Display values
# kcat -C -b <bootstrap_server_host:port> -t <topic>
kcat -C -b co7-node01:9092 -t topic-json-gpkafka

# Display key and values separated by ':'
# kcat -C -K : -b <bootstrap_server_host:port> -t <topic>
# kcat -C -K : -b co7-node01:9092 -t topic-json-gpkafka
