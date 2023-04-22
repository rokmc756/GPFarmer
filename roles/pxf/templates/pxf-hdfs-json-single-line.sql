DROP EXTERNAL TABLE IF EXISTS singleline_json_tbl;
CREATE EXTERNAL TABLE singleline_json_tbl(
  created_at TEXT,
  id_str TEXT,
  "user.id" INTEGER,
  "user.location" TEXT,
  "coordinates.values" TEXT[]
)
LOCATION('pxf://data/pxf_examples/pxf-hdfs-json-single-line.json?PROFILE=hdfs:json')
FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');

-- To query the JSON data in the external table:
SELECT * FROM singleline_json_tbl;

-- To access specific elements of the coordinates.values array, you can specify the array subscript number in square brackets:
SELECT "coordinates.values"[1], "coordinates.values"[2] FROM singleline_json_tbl;

-- To access the array elements as some type other than TEXT, you can either cast the whole column:
SELECT "coordinates.values"::int[] FROM singleline_json_tbl;

-- or cast specific elements:
SELECT "coordinates.values"[1]::int, "coordinates.values"[2]::float FROM singleline_json_tbl;
