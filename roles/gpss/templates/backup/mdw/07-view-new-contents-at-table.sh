# psql -d testdb -c "SELECT * FROM json_from_kafka WHERE customer_id=’1313131' ORDER BY amount_paid;"
psql -d testdb -c "SELECT * FROM public.json_from_kafka;"
