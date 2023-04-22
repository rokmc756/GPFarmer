DROP EXTERNAL TABLE IF EXISTS pxf_hdfs_textmulti;
CREATE EXTERNAL TABLE pxf_hdfs_textmulti(address text, month text, year int)
LOCATION ('pxf://data/pxf_examples/pxf-hdfs-multi.txt?PROFILE=hdfs:text:multi')
FORMAT 'CSV' (delimiter ':');

SELECT * FROM pxf_hdfs_textmulti;
