# echo 'text file with only one line' > /tmp/pxf-hdfs-file1.txt

#echo 'Prague,Jan,101,4875.33
#Rome,Mar,87,1557.39
#Bangalore,May,317,8936.99
#Beijing,Jul,411,11600.67' > /tmp/pxf-hdfs-file2.txt

#echo '"4627 Star Rd.
#San Francisco, CA  94107":Sept:2017
#"113 Moon St.
#San Diego, CA  92093":Jan:2018
#"51 Belt Ct.
#Denver, CO  90123":Dec:2016
#"93114 Radial Rd.
#Chicago, IL  60605":Jul:2017
#"7301 Brookview Ave.
#Columbus, OH  43213":Dec:2018' > /tmp/pxf-hdfs-file3.txt

# Copy the text files to HDFS:
#hdfs dfs -put /tmp/pxf-hdfs-file1.txt /data/pxf_examples/tdir
#hdfs dfs -put /tmp/pxf-hdfs-file2.txt /data/pxf_examples/tdir
#hdfs dfs -put /tmp/pxf-hdfs-file3.txt /data/pxf_examples/tdir

hdfs dfs -mkdir -p /data/pxf_examples/tdir

hdfs dfs -put /home/hadoop/query-examples/pxf-hdfs-file1.txt /data/pxf_examples/tdir
hdfs dfs -put /home/hadoop/query-examples/pxf-hdfs-file2.txt /data/pxf_examples/tdir
hdfs dfs -put /home/hadoop/query-examples/pxf-hdfs-file3.txt /data/pxf_examples/tdir

hdfs dfs -chown -R gpadmin:hadoop /data/pxf_examples/tdir

