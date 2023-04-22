DROP EXTERNAL TABLE IF EXISTS multiline_json_tbl;
CREATE EXTERNAL TABLE multiline_json_tbl(
  created_at TEXT,
  id_str TEXT,
  "user.id" INTEGER,
  "user.location" TEXT,
  "coordinates.values" TEXT[]
)
LOCATION('pxf://data/pxf_examples/pxf-hdfs-json-multi-line.json?PROFILE=hdfs:json&IDENTIFIER=created_at')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

SELECT * FROM multiline_json_tbl;
