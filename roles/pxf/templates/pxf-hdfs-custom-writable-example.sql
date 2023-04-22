DROP EXTERNAL TABLE IF EXISTS pxf_tbl_seqfile;
CREATE WRITABLE EXTERNAL TABLE pxf_tbl_seqfile (location text, month text, number_of_orders integer, total_sales real)
LOCATION ('pxf://data/pxf_examples/pxf_seqfile?PROFILE=hdfs:SequenceFile&DATA_SCHEMA=com.example.pxf.hdfs.writable.dataschema.PxfExample_CustomWritable&COMPRESSION_TYPE=BLOCK&COMPRESSION_CODEC=bzip2')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_export');

INSERT INTO pxf_tbl_seqfile VALUES ( 'Frankfurt', 'Mar', 777, 3956.98 );
INSERT INTO pxf_tbl_seqfile VALUES ( 'Cleveland', 'Oct', 3812, 96645.37 );

DROP EXTERNAL TABLE IF EXISTS read_pxf_tbl_seqfile;
CREATE EXTERNAL TABLE read_pxf_tbl_seqfile (location text, month text, number_of_orders integer, total_sales real)
LOCATION ('pxf://data/pxf_examples/pxf_seqfile?PROFILE=hdfs:SequenceFile&DATA_SCHEMA=com.example.pxf.hdfs.writable.dataschema.PxfExample_CustomWritable')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

SELECT * FROM read_pxf_tbl_seqfile ORDER BY total_sales;

-- testdb=# INSERT INTO pxf_tbl_seqfile VALUES ( 'Frankfurt', 'Mar', 777, 3956.98 );
-- ERROR:  PXF server error : org.greenplum.pxf.plugins.hdfs.WritableResolver requires a data schema to be specified in the pxf uri, but none was found. Please supply itusing the DATA-SCHEMA option  (seg7 192.168.0.174:6003 pid=5400)
-- HINT:  Check the PXF logs located in the '/home/gpadmin/pxf-hadoop-base//logs' directory on host 'rk8-node02.jtest.pivotal.io' or 'set client_min_messages=LOG' for additional details.
