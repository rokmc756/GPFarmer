# On hadoop Master
mkdir -p /home/hadoop/query-examples/pxfex/com/example/pxf/hdfs/writable/dataschema
cd /home/hadoop/query-examples/pxfex/com/example/pxf/hdfs/writable/dataschema

javac -classpath /home/hadoop/hadoop-3.3.5/share/hadoop/common/hadoop-common-3.3.5.jar \
pxf-hdfs-custom-writable-example.java

cd ../../../../../../
# jar cf pxfex-custom-writable.jar com
jar cf pxf-hdfs-custom-writable-example.java com

# cp pxfex-customwritable.jar /tmp/
cp cf pxf-hdfs-custom-writable-example.java /tmp

# On Hadoop Master
# scp pxfex-customwritable.jar gpadmin@gpmaster:/home/gpadmin
sshpass -p 'changeme' scp pxf-hdfs-custom-writable-example.java gpadmin@rk8-master:/home/gpadmin
