------------------------------------------------------------------
-- Setup Formatters
------------------------------------------------------------------

CREATE OR REPLACE FUNCTION delimited_in() RETURNS record
AS '$libdir/gpfmt_delimiter.so', 'delimited_import'
LANGUAGE C STABLE;

CREATE OR REPLACE FUNCTION json_in() RETURNS record
AS '$libdir/gpfmt_json.so', 'json_import'
LANGUAGE C STABLE;

CREATE OR REPLACE FUNCTION avro_in() RETURNS record
AS '$libdir/gpfmt_avro.so', 'avro_import'
LANGUAGE C STABLE;

CREATE OR REPLACE FUNCTION confluent_avro_in() RETURNS record
AS '$libdir/gpfmt_confluent_avro.so','confluent_avro_import'
LANGUAGE C STABLE;

CREATE OR REPLACE FUNCTION kafka_in() RETURNS record
AS '$libdir/gpfmt_kafka.so','kafka_import'
LANGUAGE C STABLE;

CREATE OR REPLACE FUNCTION protobuf_in() RETURNS record
AS '$libdir/gpfmt_protobuf.so', 'formatter_import'
LANGUAGE C STABLE;

CREATE OR REPLACE FUNCTION protobuf_out(record) RETURNS bytea
AS '$libdir/gpfmt_protobuf.so', 'formatter_export'
LANGUAGE C STABLE;

CREATE OR REPLACE FUNCTION binary_in() RETURNS record
AS '$libdir/gpfmt_binary.so', 'binary_import'
LANGUAGE C STABLE;

CREATE OR REPLACE FUNCTION gpfmt_version() RETURNS text
AS '$libdir/gpss.so', 'gpfmt_version'
LANGUAGE C STABLE;
