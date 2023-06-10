#!/bin/sh
echo "This script introduces segment failure for content=1 and the candidate needs to take steps to recover the segment"
echo "#################################################"
echo "Creating Database labtest1"
psql template1 -c "create database labtest1"
echo "Done!"
echo "#################################################"
echo "Creating database objects:"
psql labtest1 -c 'create table table_test(id int, name text)';
psql labtest1 -c "copy gp_segment_configuration to '/tmp/copy.out'"
psql labtest1 -c "insert into table_test(id, name) values(generate_series(1,100000), 'AAAAAAAAAAA');"
echo "#################################################"
echo "Marking segment down":
hostname1=$(psql labtest1 -Atc "select hostname from gp_segment_configuration where preferred_role='m' and content=1;")
corrupt=$(psql labtest1 -Atc "select 'rm -rf '|| datadir ||'/*' from gp_segment_configuration where preferred_role='m' and content=1;")
seg_down=$(psql labtest1 -Atc "set allow_system_table_mods='y';update gp_segment_configuration set status='d', mode='n' where preferred_role='m' and content=1;")
seg_down2=$(psql labtest1 -Atc "set allow_system_table_mods='y';update gp_segment_configuration set mode='n' where preferred_role='p' and content=1;") 
gphome=$GPHOME
echo "Working on the segment:"
echo $hostname1
ssh -tt $hostname1 "$corrupt"		
$seg_down
$seg_down2
echo "#################################################"
echo ""
echo "Done! Please run 'gpstate -e' and recover the segment marked down."
