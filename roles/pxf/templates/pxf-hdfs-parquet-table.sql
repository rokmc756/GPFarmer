DROP EXTERNAL TABLE IF EXISTS pxf_tbl_parquet;
CREATE WRITABLE EXTERNAL TABLE pxf_tbl_parquet (location text, month text, number_of_orders int, item_quantity_per_order int[], total_sales double precision)
LOCATION ('pxf://data/pxf_examples/pxf_parquet?PROFILE=hdfs:parquet')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_export');
-- CREATE EXTERNAL TABLE

INSERT INTO pxf_tbl_parquet VALUES ( 'Frankfurt', 'Mar', 3, '{1,11,111}', 3956.98 );
-- INSERT 0 1

INSERT INTO pxf_tbl_parquet VALUES ( 'Cleveland', 'Oct', 2, '{3333,7777}', 96645.37 );
-- INSERT 0 1

DROP EXTERNAL TABLE IF EXISTS read_pxf_parquet;
CREATE EXTERNAL TABLE read_pxf_parquet(location text, month text, number_of_orders int, item_quantity_per_order int[], total_sales double precision)
LOCATION ('pxf://data/pxf_examples/pxf_parquet?PROFILE=hdfs:parquet')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
-- CREATE EXTERNAL TABLE

SELECT * FROM read_pxf_parquet ORDER BY total_sales;
--  location  | month | number_of_orders | item_quantity_per_order | total_sales
-------------+-------+------------------+-------------------------+-------------
-- Frankfurt | Mar   |                3 | {1,11,111}              |     3956.98
-- Cleveland | Oct   |                2 | {3333,7777}             |    96645.37
-- (2 rows)
