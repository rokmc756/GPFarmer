DROP EXTERNAL TABLE IF EXISTS pxf_avrowrite;
CREATE WRITABLE EXTERNAL TABLE pxf_avrowrite(id int, username text, followers text[])
LOCATION ('pxf://data/pxf_examples/pxfwrite.avro?PROFILE=hdfs:avro')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_export');

INSERT INTO pxf_avrowrite VALUES (33, 'oliver', ARRAY['alex','frank']);
INSERT INTO pxf_avrowrite VALUES (77, 'lisa', ARRAY['tom','mary']);

-- PXF uses the external table definition to generate the Avro schema.
-- Create an external table to read the Avro data that you just inserted into the table:
DROP EXTERNAL TABLE IF EXISTS read_pxfwrite;
CREATE EXTERNAL TABLE read_pxfwrite(id int, username text, followers text[])
LOCATION ('pxf://data/pxf_examples/pxfwrite.avro?PROFILE=hdfs:avro')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

-- Read the Avro data by querying the read_pxfwrite table:
SELECT id, followers, followers[1], followers[2] FROM read_pxfwrite ORDER BY id;
