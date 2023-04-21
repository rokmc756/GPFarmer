CREATE EXTERNAL TABLE multiline_json_tbl(
  created_at TEXT,
  id_str TEXT,
  "user.id" INTEGER,
  "user.location" TEXT,
  "coordinates.values" TEXT[]
)
LOCATION('pxf://data/pxf_examples/multiline.json?PROFILE=hdfs:json&IDENTIFIER=created_at')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

SELECT * FROM multiline_json_tbl;
