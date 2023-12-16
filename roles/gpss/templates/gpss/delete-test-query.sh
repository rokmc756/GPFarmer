# psql -d testdb -c "
# DELETE FROM ibl.iiblcect001tm t10 USING temp_iiblcect001tm_w01 t11 WHERE t10.ebnk_utzpe_no = t11.ebnk_utzpe_no;
#"

psql -d testdb -c "
    CREATE TEMP TABLE json_from_kafka_temp_delete_test AS TABLE json_from_kafka_delete_test;
"

psql -d testdb -c "
    DELETE FROM json_from_kafka_delete_test t10 USING json_from_kafka_temp_delete_test t11 WHERE t10.ebnk_utzpe_no = t11.ebnk_utzpe_no;
"
