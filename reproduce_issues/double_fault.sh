#!/bin/bash

psql -Atc "select a.hostname,a.port,b.fselocation from gp_segment_configuration a, pg_filespace_entry b where dbid = fsedbid and content = 0 and role = 'p'" | while read line;
do
createdb orange
export hostname=`echo $line | cut -d'|' -f1`
export port=`echo $line | cut -d'|' -f2`
export directory=`echo $line | cut -d'|' -f3`
export relfilenode=`PGOPTIONS='-c gp_session_role=utility' psql -h $hostname -p $port -Atc "select relfilenode from pg_class where relname = 'foo'"`
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 $hostname "kill -9 \$(ps -ef | grep contentid=0 | grep gp_dbid=2| grep -v grep | awk '{print \$2}')"
export xlog_file=`ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 $hostname "ls -Art $directory/pg_xlog | tail -n 1"`
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 $hostname "rm $directory/pg_xlog/$xlog_file"

echo -e "########################################################################################"
echo -e "This script will simulate a situation where we will need to recover from a double fault."
echo -e "Please give a couple minutes for the script to complete..."
echo -e "########################################################################################\n"
sleep 2m
gpstate -e


psql orange -c 'CREATE SCHEMA test_schema;'
psql orange -c 'create table test_schema.test (id int, name text);'
psql orange -c 'create index idx_test on test_schema.test(name);'
psql orange -c "insert into test_schema.test values(generate_series(1,1000000), 'test')"
done


psql -Atc "select a.hostname,a.port,b.fselocation from gp_segment_configuration a, pg_filespace_entry b where dbid = fsedbid and content=0 and role = 'p'" | while read line;
do
export hostname1=`echo $line | cut -d'|' -f1`
export port1=`echo $line | cut -d'|' -f2`
export directory1=`echo $line | cut -d'|' -f3`
ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 $hostname1 "rm -rf $directory1"
done

gpstate -e
gpstop -af
gpstart -a

echo -e "\n"
echo -e "########################################################################################################"
echo -e " The customer is reporting the database is unable to start up. If you examine the "
echo -e " gpstart output, you will see that segment 0's mirror is now the acting primary, however it's" 
echo -e " data directory is missing in sdw2. This can happen if there is a segment failover and then a" 
echo -e " hardware issue in sdw2. The original primary is still intact.\n"
echo -e " While segment 0 was on it's mirror, a table with 1000000 rows was created in database orange."
echo -e " The customer is asking support to bring the cluster back up with the expectation of some data loss."
echo -e " They would like us to save as much data in test_schema.test table. This will require "
echo -e " a pg_resetxlog. Please note, any pg_resetxlog activity will REQUIRE engineering to be paged.\n"
echo -e " We will need to take the following steps to bring up the cluster:"
echo -e " 1. Manually bring up the original primary segment 0"
echo -e " 2. gpstart of the database will again report a double fault. Investigate the error in seg 0 primary log."
echo -e " 3. Perform pg_resetxlog. Please refer to the pg_resetxlog TOI on how to do this."
echo -e " 4. After resetxlog, run gpcheckcat -A and investigate what catalog issues need to be fixed." 
echo -e " 5. In the orange database, try select * from test_schema.test"
echo -e " 6. Fix all the catalog issues."
echo -e " 7. Rebuild Persistent Table"
echo -e " 8. Run gpcheckcat -A again to reveal a couple Persistent Table issues remain.\n"
echo -e " Advanced: See if you can figure out how resolve the last remaining issues without truncating the table!\n"
echo -e " Lastly, run a full recovery and rebalance\n"
echo -e " Once there are no catalog issues reported and there are 750000 rows in test_schema.test table,"
echo -e " the issue is considered resolved.\n"
echo -e "#######################################################################################################\n"

