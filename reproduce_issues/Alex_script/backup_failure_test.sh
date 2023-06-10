#!/bin/sh
echo "This script introduces segment failure for content=1 and the candidate needs to take steps to recover the segment"
echo "#################################################"
echo "Creating Database labtest3"
psql template1 -c "create database labtest3"
echo "Done!"
echo "#################################################"
echo "Creating database objects:"
psql labtest3 -c 'create table table_test(id int, name text)';
psql labtest3 -c "copy gp_segment_configuration to '/tmp/copy.out'"
psql labtest3 -c "insert into table_test(id, name) values(generate_series(1,100000), 'AAAAAAAAAAA');"
echo "#################################################"
echo "Working on the database:"
hostname1=$(psql labtest3 -Atc "select hostname from gp_segment_configuration where preferred_role='p' and content=1;")
portnum=$(psql labtest3 -Atc "select port from gp_segment_configuration where preferred_role='p' and content=1;")
catalog=$(PGOPTIONS='-c gp_session_role=utility' psql -p $portnum -h $hostname1 labtest3 -c "set allow_system_table_mods=y;delete from pg_class where relname='table_test';")
gphome=$GPHOME
$catalog
echo "Done working on database!"
echo "#################################################"
echo ""
echo "Now try using the gpbackup utlity to take a full backup of the 'labtest3' database. If it fails, troubleshoot it and then test the backup again."


