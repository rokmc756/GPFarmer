createdb labtest;

psql labtest -c 'create table table_test(id int, name text)';

psql labtest -c "insert into table_test(id, name) values(generate_series(1,100000), 'AAAAAAAAAAA');"

relfilenode=$(psql labtest -Atc "select relfilenode from gp_dist_random('pg_class') where relname = 'table_test' and gp_segment_id = 1;")

host=$(psql labtest -Atc "select address from gp_segment_configuration where content = 1 and role='p'")

directory=$(psql labtest -Atc "select datadir from gp_segment_configuration where content = 1 and role='p'")

dboid=$(psql labtest -Atc "select oid from pg_database where datname = 'labtest'")

tablepath=${directory}/base/${dboid}/${relfilenode}

sshcommand="dd if=/dev/urandom of="$tablepath" bs=1M count=10"

ssh -tt $host "$sshcommand"

echo "Querying from table table_test is failing with page verification failed. Can you figure out how to fix this so all 100,000 rows are saved?"

psql labtest -c 'select count(*) from table_test';
