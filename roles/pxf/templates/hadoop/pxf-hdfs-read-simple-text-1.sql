
DROP EXTERNAL TABLE IF EXISTS pxf_hdfs_textsimple_r1;

CREATE EXTERNAL TABLE pxf_hdfs_textsimple_r1(location text, month text, num_orders int, total_sales float8)
LOCATION ('pxf://data/pxf_examples/pxfwritable_hdfs_textsimple1?PROFILE=hdfs:text')
FORMAT 'CSV';

SELECT * FROM pxf_hdfs_textsimple_r1 ORDER BY total_sales;
