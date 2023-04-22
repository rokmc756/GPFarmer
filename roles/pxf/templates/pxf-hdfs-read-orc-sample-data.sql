DROP EXTERNAL TABLE IF EXISTS sample_orc;
CREATE EXTERNAL TABLE sample_orc(location text, month text, num_orders int, total_sales numeric(10,2), items_sold text[])
LOCATION ('pxf://data/pxf_examples/orc_example?PROFILE=hdfs:orc')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

SELECT * FROM sample_orc;

SELECT * FROM sample_orc WHERE items_sold && '{"boots", "pants"}';

SELECT * FROM sample_orc WHERE items_sold[0] = 'boots';
