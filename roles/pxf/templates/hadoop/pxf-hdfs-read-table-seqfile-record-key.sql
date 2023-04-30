DROP EXTERNAL TABLE IF EXISTS read_pxf_tbl_seqfile_recordkey;
CREATE EXTERNAL TABLE read_pxf_tbl_seqfile_recordkey(recordkey int8, location text, month text, number_of_orders integer, total_sales real)
LOCATION ('pxf://data/pxf_examples/pxf_seqfile?PROFILE=hdfs:SequenceFile&DATA_SCHEMA=com.example.pxf.hdfs.writable.dataschema.PxfExample_CustomWritable')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

SELECT * FROM read_pxf_tbl_seqfile_recordkey;
