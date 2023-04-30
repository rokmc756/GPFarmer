DROP EXTERNAL TABLE IF EXISTS write_to_sample_orc;
CREATE WRITABLE EXTERNAL TABLE write_to_sample_orc (location text, month text, num_orders int, total_sales numeric(10,2), items_sold text[] )
    LOCATION ('pxf://data/pxf_examples/orc_example?PROFILE=hdfs:orc')
  FORMAT 'CUSTOM' (FORMATTER='pxfwritable_export');

INSERT INTO write_to_sample_orc VALUES ( 'Frankfurt', 'Mar', 777, 3956.98, '{"winter socks","pants",boots}' );
INSERT INTO write_to_sample_orc VALUES ( 'Cleveland', 'Oct', 3218, 96645.37, '{"long-sleeved shirts",hats}' );

-- Recall that Greenplum Database does not support directly querying a writable external table. Query the sample_orc table that you created in the previous example to read the new data that you added:
SELECT * FROM sample_orc ORDER BY num_orders;
