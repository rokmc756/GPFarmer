# https://repo1.maven.org/maven2/org/apache/orc/orc-tools/1.8.3/orc-tools-1.8.3.jar

#[hadoop@co7-master ~]$ java -jar orc-tools-1.8.3-uber.jar convert /tmp/sample-data-orc.json --schema 'struct<location:string,month:string,num_orders:int,total_sales:decimal(10,2),items_sold:array<string>>' -o /tmp/sample-data-orc.orc
#log4j:WARN No appenders could be found for logger (org.apache.hadoop.util.Shell).
#log4j:WARN Please initialize the log4j system properly.
#log4j:WARN See http://logging.apache.org/log4j/1.2/faq.html#noconfig for more info.
#Processing /tmp/sample-data-orc.json
#Exception in thread "main" java.lang.IllegalStateException: Not a JSON Object: "$"
#	at com.google.gson.JsonElement.getAsJsonObject(JsonElement.java:91)
#	at org.apache.orc.tools.convert.JsonReader.nextBatch(JsonReader.java:409)
#	at org.apache.orc.tools.convert.ConvertTool.run(ConvertTool.java:221)
#	at org.apache.orc.tools.convert.ConvertTool.main(ConvertTool.java:173)
#	at org.apache.orc.tools.Driver.main(Driver.java:109)

# echo '{"location": "Prague", "month": "Jan","num_orders": 101, "total_sales": 4875.33, "items_sold": ["boots", "hats"]}
# {"location": "Rome", "month": "Mar","num_orders": 87, "total_sales": 1557.39, "items_sold": ["coats"]}
#{"location": "Bangalore", "month": "May","num_orders": 317, "total_sales": 8936.99, "items_sold": ["winter socks", "long-sleeved shirts", "boots"]}
#{"location": "Beijing", "month": "Jul","num_orders": 411, "total_sales": 11600.67, "items_sold": ["hoodies/sweaters", "pants"]}
#{"location": "Los Angeles", "month": "Dec","num_orders": 0, "total_sales": 0.00, "items_sold": null}' > /tmp/pxf-hdfs-sample-data-orc.json

# java -jar /home/gpadmin/query-examples/orc-tools-1.8.3-uber.jar convert /tmp/pxf-hdfs-sample-data-orc.json --schema 'struct<location:string,month:string,num_orders:int,total_sales:decimal(10,2),items_sold:array<string>>' -o /tmp/pxf-hdfs-sample-data-orc.orc
java -jar /home/hadoop/query-examples/orc-tools-1.8.3-uber.jar convert /home/hadoop/query-examples/pxf-hdfs-sample-data-orc.json --schema 'struct<location:string,month:string,num_orders:int,total_sales:decimal(10,2),items_sold:array<string>>' -o /home/hadoop/query-examples/pxf-hdfs-sample-data-orc.orc

# log4j:WARN No appenders could be found for logger (org.apache.hadoop.util.Shell).
# log4j:WARN Please initialize the log4j system properly.
# log4j:WARN See http://logging.apache.org/log4j/1.2/faq.html#noconfig for more info.
# Processing /tmp/sample-data-orc.json

hdfs dfs -mkdir -p /data/pxf_examples/orc_example

# hdfs dfs -put /tmp/pxf-hdfs-sample-data-orc.orc /data/pxf_examples/orc_example
hdfs dfs -put /home/hadoop/query-examples/pxf-hdfs-sample-data-orc.orc /data/pxf_examples/orc_example
