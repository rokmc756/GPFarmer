
echo 'Enter GPDB Version for catalog corruption Choose one from 4,5,6'
read gpdbVersion

echo 'Enter Segment host to create catalog corruption enteries'
read segHost

echo 'Enter port for segment for entries'
read port

echo 'Creating database for catalog corruption'

psql -c "drop database catalogtesting;"
psql -c "create database catalogtesting template template1;"


psql -d catalogtesting -c "create table large_att_table (id1 int,id2 int,id3 int,id4 int,id5 int,id6 int,id7 int,id8 int,id9 int,id10 int,name text);create table sales (id1 int,id2 int,id3 int,id4 int,id5 int,id6 int,id7 int,id8 int,id9 int,id10 int,name text); create table ao_test (id int) with(appendonly=true);" 

echo 'Successfully created Database and tables for catalogtesting'

if [ $gpdbVersion -ne 6 ]; then

	echo $segHost
	echo $port
	
    PGOPTIONS='-c gp_session_role=utility' psql -h $segHost -p $port -d catalogtesting -c "set allow_system_table_mods = dml; delete from pg_class where relname=(select 'pg_aoseg_' || oid from pg_class where relname='ao_test');"
    PGOPTIONS='-c gp_session_role=utility' psql -h $segHost -p $port -d catalogtesting -c "set allow_system_table_mods = dml; delete from pg_attribute where attname in ('id4','name') and attrelid ='large_att_table'::regclass ; delete from pg_attribute where attname in ('id4','name','id5','id6','id2') and attrelid ='sales'::regclass";
    PGOPTIONS='-c gp_session_role=utility' psql -h $segHost -p $port -d catalogtesting -c "set allow_system_table_mods = dml; create table employee(id int,name text) with (appendonly=true,orientation=column); copy(select oid,* from pg_type where typrelid ='employee'::regclass) to '/home/gpadmin/pg_type_dup.out'; update pg_index set indisvalid='f',indisunique='f' where indrelid='pg_type'::regclass; copy pg_type from '/home/gpadmin/pg_type_dup.out' with oids; update pg_index set indisvalid='t',indisunique='t' where indrelid='pg_type'::regclass;"
else
	PGOPTIONS='-c gp_session_role=utility' psql -h $segHost -p $port -d catalogtesting -c "set allow_system_table_mods = on; delete from pg_class where relname=(select 'pg_aoseg_' || oid from pg_class where relname='ao_test');"
    PGOPTIONS='-c gp_session_role=utility' psql -h $segHost -p $port -d catalogtesting -c "set allow_system_table_mods = on; delete from pg_attribute where attname in ('id4','name') and attrelid ='large_att_table'::regclass ; delete from pg_attribute where attname in ('id4','name','id5','id6','id2') and attrelid ='sales'::regclass";
    PGOPTIONS='-c gp_session_role=utility' psql -h $segHost -p $port -d catalogtesting -c "set allow_system_table_mods = on; create table employee(id int,name text) with (appendonly=true,orientation=column); copy(select oid,* from pg_type where typrelid ='employee'::regclass) to '/home/gpadmin/pg_type_dup.out'; update pg_index set indisvalid='f',indisunique='f' where indrelid='pg_type'::regclass; copy pg_type from '/home/gpadmin/pg_type_dup.out' with oids; update pg_index set indisvalid='t',indisunique='t' where indrelid='pg_type'::regclass;"

fi

echo 'Success. Please proceed to catalog fixing'
