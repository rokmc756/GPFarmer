#!/bin/sh
echo "This script introduces segment failure for content=1 and the candidate needs to take steps to recover the segment"
echo "#################################################"
echo "Creating Database labtest4"
psql template1 -c "create database labtest4"
echo "Done!"
echo "#################################################"
echo "Creating database objects:"
psql labtest4 -c 'create table table_test(id int, name text)';
psql labtest4 -c "insert into table_test(id, name) values(generate_series(1,100000), 'AAAAAAAAAAA');"
hostname1=$(psql labtest4 -Atc "select hostname from gp_segment_configuration where preferred_role='p' and content=1;")
portnum=$(psql labtest4 -Atc "select port from gp_segment_configuration where preferred_role='p' and content=1;")
PGOPTIONS='-c gp_session_role=utility' nohup psql -p $portnum -h $hostname1 labtest4 -c "begin; lock table table_test in ACCESS EXCLUSIVE mode;select pg_sleep(10000);" &
## nohup psql labtest4 -c "begin; lock table table_test in ACCESS EXCLUSIVE mode;select pg_sleep(10000);" &
echo "#################################################"
echo "Running a truncate on table_test"
nohup psql labtest4 -c "truncate table_test" &
echo "Please investigate as to why is the table_test truncate statement hung!!!"
