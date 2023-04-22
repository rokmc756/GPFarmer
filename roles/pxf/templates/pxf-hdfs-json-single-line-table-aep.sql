DROP EXTERNAL TABLE IF EXISTS singleline_json_tbl_aep;
CREATE EXTERNAL TABLE singleline_json_tbl_aep(
  created_at TEXT,
  id_str TEXT,
  "user.id" INTEGER,
  "user.location" TEXT,
  "coordinates.values[0]" INTEGER,
  "coordinates.values[1]" INTEGER
)
LOCATION('pxf://data/pxf_examples/singleline.json?PROFILE=hdfs:json')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

ALTER EXTERNAL TABLE singleline_json_tbl_aep DROP COLUMN "coordinates.values[0]", DROP COLUMN "coordinates.values[1]", ADD COLUMN "coordinates.values" TEXT[];
