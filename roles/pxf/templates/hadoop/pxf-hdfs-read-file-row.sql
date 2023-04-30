DROP EXTERNAL TABLE IF EXISTS pxf_readfileasrow;
CREATE EXTERNAL TABLE pxf_readfileasrow(c1 text)
LOCATION ('pxf://data/pxf_examples/tdir?PROFILE=hdfs:text:multi&FILE_AS_ROW=true')
FORMAT 'CSV';

--
\x on
SELECT * FROM pxf_readfileasrow;
