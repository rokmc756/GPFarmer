DROP EXTERNAL TABLE IF EXISTS pxf_hdfs_fixedwidth_r;
CREATE EXTERNAL TABLE pxf_hdfs_fixedwidth_r(location text, month text, num_orders int, total_sales float8)
LOCATION ('pxf://data/pxf_examples/pxf_hdfs_fixedwidth.txt?PROFILE=hdfs:fixedwidth&NEWLINE=CRLF')
FORMAT 'CUSTOM' (formatter='fixedwidth_in', location='15', month='4', num_orders='6', total_sales='10', line_delim=E'\r\n');

-- testdb=# SELECT * FROM pxf_hdfs_fixedwidth_r;
-- ERROR:  The line delimiter specified in the Formatter arguments: <
-- is not located in the data file  (seg3 slice1 192.168.0.173:6003 pid=3239)
-- CONTEXT:  External table pxf_hdfs_fixedwidth_r

-- testdb=# DROP EXTERNAL TABLE pxf_hdfs_fixedwidth_r;
-- DROP EXTERNAL TABLE
