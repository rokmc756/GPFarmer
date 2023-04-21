hdfs dfs -mkdir -p /data/pxf_examples
echo 'Prague,Jan,101,4875.33
Rome,Mar,87,1557.39
Bangalore,May,317,8936.99
Beijing,Jul,411,11600.67' > /tmp/pxf_hdfs_simple.txt
hdfs dfs -put /tmp/pxf_hdfs_simple.txt /data/pxf_examples/
hdfs dfs -cat /data/pxf_examples/pxf_hdfs_simple.txt
