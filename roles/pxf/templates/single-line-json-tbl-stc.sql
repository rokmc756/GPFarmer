CREATE EXTERNAL TABLE singleline_json_tbl_stc(
  created_at TEXT,
  id_str TEXT,
  "user.id" INTEGER,
  "user.location" TEXT,
  "coordinates.values" TEXT
)
LOCATION('pxf://data/pxf_examples/singleline.json?PROFILE=hdfs:json')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

SELECT user.id,
       ARRAY(SELECT json_array_elements_text(coordinates.values::json))::int[] AS coords
FROM singleline_json_tbl_stc;
-- ERROR:  syntax error at or near "."
-- LINE 1: SELECT user.id,
--                   ^
-- testdb=#


ALTER EXTERNAL TABLE singleline_json_tbl_stc ALTER COLUMN "coordinates.values" TYPE TEXT[];
