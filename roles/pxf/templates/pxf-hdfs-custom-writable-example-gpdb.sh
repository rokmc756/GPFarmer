# On GPDB master
# cp /home/gpadmin/pxfex-customwritable.jar /usr/local/pxf-gp6/lib/pxfex-customwritable.jar
cp /home/gpadmin/query-examples/pxf-hdfs-custom-writable-example.jar /usr/local/pxf-gp6/lib/pxf-hdfs-custom-writable-example.jar

# mv /usr/local/pxf-gp6/lib/pxfex-customwritable.jar /home/gpadmin/pxf-hadoop-base/lib/
mv /usr/local/pxf-gp6/lib/pxf-hdfs-custom-writable-example.jar /home/gpadmin/pxf-hadoop-base/lib/

PXF_BASE=/home/gpadmin/pxf-hadoop-base/ pxf cluster sync
