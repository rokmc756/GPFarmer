DROP EXTERNAL TABLE IF EXISTS pxf_hdfs_avro;
CREATE EXTERNAL TABLE pxf_hdfs_avro(id bigint, username text, followers text[], fmap text, relationship text, address text)
LOCATION ('pxf://data/pxf_examples/pxf_avro.avro?PROFILE=hdfs:avro&COLLECTION_DELIM=,&MAPKEY_DELIM=:&RECORDKEY_DELIM=:')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');


SELECT * FROM pxf_hdfs_avro;

SELECT id, followers[1] FROM pxf_hdfs_avro;
