CREATE EXTERNAL TABLE pxf_read_nfs(location text, month text, num_orders int, total_sales float8)
LOCATION ('pxf://ex1/?PROFILE=file:text&SERVER=nfssrvcfg')
FORMAT 'CSV';
