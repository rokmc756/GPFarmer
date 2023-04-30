for i in `seq 1 10000`
do
    sleep 1
    psql -d testdb -c "INSERT INTO countries1 SELECT * from countries WHERE country_id=3;"
    sleep 1
done
