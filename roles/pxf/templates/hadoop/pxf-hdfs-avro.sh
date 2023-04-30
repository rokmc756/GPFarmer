# wget https://dlcdn.apache.org/avro/avro-1.11.1/java/avro-tools-1.11.1.jar
# java -jar /home/gpadmin/query-examples/avro-tools-1.11.1.jar fromjson --schema-file /tmp/avro_schema.avsc /tmp/pxf-hdfs-avro.txt > /tmp/pxf-hdfs-avro.avro
java -jar /home/hadoop/query-examples/avro-tools-1.11.1.jar fromjson \
--schema-file /home/hadoop/query-examples/avro_schema.avsc \
/home/hadoop/query-examples/pxf-hdfs-avro.txt > /home/hadoop/query-examples/pxf-hdfs-avro.avro

#[root@co7-master ~]# chown hadoop.hadoop /tmp/pxf_*
#[root@co7-master ~]# su - hadoop
#Last login: Fri Apr 21 23:56:56 KST 2023 on pts/0
#[hadoop@co7-master ~]$ java -jar ./avro-tools-1.11.1.jar fromjson --schema-file /tmp/avro_schema.avsc /tmp/pxf_avro.txt > /tmp/pxf_avro.avro
#23/04/21 23:57:16 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable

# hdfs dfs -put /tmp/pxf-hdfs-avro.avro /data/pxf_examples/
hdfs dfs -put /home/hadoop/query-examples/pxf-hdfs-avro.avro /data/pxf_examples/

