# On hadoop Master
mkdir -p pxfex/com/example/pxf/hdfs/writable/dataschema
cd pxfex/com/example/pxf/hdfs/writable/dataschema

javac -classpath /home/hadoop/hadoop-3.3.5/share/hadoop/common/hadoop-common-3.3.5.jar PxfExample_CustomWritable.java

cd ../../../../../../
jar cf pxfex-customwritable.jar com
cp pxfex-customwritable.jar /tmp/

scp pxfex-customwritable.jar gpadmin@gpmaster:/home/gpadmin

# On gpdb master

cp /home/gpadmin/pxfex-customwritable.jar /usr/local/pxf-gp6/lib/pxfex-customwritable.jar

mv /usr/local/pxf-gp6/lib/pxfex-customwritable.jar  /home/gpadmin/pxf-hadoop-base/lib/

PXF_BASE=/home/gpadmin/pxf-hadoop-base/ pxf cluster sync

