DROP EXTERNAL TABLE IF EXISTS pxf_hdfs_fixedwidth_w;
CREATE WRITABLE EXTERNAL TABLE pxf_hdfs_fixedwidth_w(location text, month text, num_orders int, total_sales float8)
LOCATION ('pxf://data/pxf_examples/fixedwidth_write?PROFILE=hdfs:fixedwidth')
FORMAT 'CUSTOM' (formatter='fixedwidth_out', location='15', month='4', num_orders='6', total_sales='10');

INSERT INTO pxf_hdfs_fixedwidth_w VALUES ( 'Frankfurt', 'Mar', 777, 3956.98 );
INSERT INTO pxf_hdfs_fixedwidth_w VALUES ( 'Cleveland', 'Oct', 3812, 96645.37 );

-- Greenplum Database does not support directly querying a writable external table. To query the data that you just added to HDFS, you must create a readable external Greenplum Database table that references the HDFS directory:
DROP EXTERNAL TABLE IF EXISTS pxf_hdfs_fixedwidth_r2;
CREATE EXTERNAL TABLE pxf_hdfs_fixedwidth_r2(location text, month text, num_orders int, total_sales float8)
LOCATION ('pxf://data/pxf_examples/fixedwidth_write?PROFILE=hdfs:fixedwidth')
FORMAT 'CUSTOM' (formatter='fixedwidth_in', location='15', month='4', num_orders='6', total_sales='10');

-- Query the readable external table:
SELECT * FROM pxf_hdfs_fixedwidth_r2 ORDER BY total_sales;
