DROP EXTERNAL TABLE IF EXISTS pxf_hdfs_writabletbl_1;
CREATE WRITABLE EXTERNAL TABLE pxf_hdfs_writabletbl_1(location text, month text, num_orders int, total_sales float8)
LOCATION ('pxf://data/pxf_examples/pxfwritable_hdfs_textsimple1?PROFILE=hdfs:text')
FORMAT 'TEXT' (delimiter=',');
-- CREATE EXTERNAL TABLE

INSERT INTO pxf_hdfs_writabletbl_1 VALUES ( 'Frankfurt', 'Mar', 777, 3956.98 );
-- ERROR:  PXF server error : Permission denied: user=gpadmin, access=WRITE, inode="/data/pxf_examples":hadoop:supergroup:drwxr-xr-x  (seg7 192.168.0.174:6003 pid=1831)
-- HINT:  Check the PXF logs located in the '/home/gpadmin/pxf-hadoop-base//logs' directory on host 'rk8-node02.jtest.pivotal.io' or 'set client_min_messages=LOG' for additional details.

INSERT INTO pxf_hdfs_writabletbl_1 VALUES ( 'Cleveland', 'Oct', 3812, 96645.37 );
-- ERROR:  PXF server error : Permission denied: user=gpadmin, access=WRITE, inode="/data/pxf_examples":hadoop:supergroup:drwxr-xr-x  (seg2 192.168.0.173:6002 pid=1853)
-- HINT:  Check the PXF logs located in the '/home/gpadmin/pxf-hadoop-base//logs' directory on host 'rk8-node01.jtest.pivotal.io' or 'set client_min_messages=LOG' for additional details.

INSERT INTO pxf_hdfs_writabletbl_1 SELECT * FROM pxf_hdfs_textsimple;
-- ERROR:  PXF server error : Permission denied: user=gpadmin, access=WRITE, inode="/data/pxf_examples":hadoop:supergroup:drwxr-xr-x  (seg6 192.168.0.174:6002 pid=1830)
-- HINT:  Check the PXF logs located in the '/home/gpadmin/pxf-hadoop-base//logs' directory on host 'rk8-node02.jtest.pivotal.io' or 'set client_min_messages=LOG' for additional details.
