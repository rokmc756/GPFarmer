DROP EXTERNAL TABLE IF EXISTS pxf_hdfs_writabletbl_2;
CREATE WRITABLE EXTERNAL TABLE pxf_hdfs_writabletbl_2 (location text, month text, num_orders int, total_sales float8)
LOCATION ('pxf://data/pxf_examples/pxfwritable_hdfs_textsimple2?PROFILE=hdfs:text&COMPRESSION_CODEC=gzip')
FORMAT 'TEXT' (delimiter=':');

INSERT INTO pxf_hdfs_writabletbl_2 VALUES ( 'Frankfurt', 'Mar', 777, 3956.98 );
INSERT INTO pxf_hdfs_writabletbl_2 VALUES ( 'Cleveland', 'Oct', 3812, 96645.37 );
