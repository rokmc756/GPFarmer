# su - gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && source /usr/local/greenplum-cc/gpcc_path.sh && timeout -s 9 10s gpcc stop"
# echo $?

#[ TEST_COMMAND ] && (
#  THEN_EXPRESSIONS
#) || (
#  ELSE_EXPRESSIONS
#)

echo "wal"
echo "$(ps -ef | grep postgres | grep 'wal receiver' | grep -v grep)"
echo "postgres"
echo "$(ps -ef | grep postgres | grep -v grep)"
echo "pidof"
echo "$(pidof postgres)"

if [ -z "$(ps -ef | grep postgres | grep 'wal receiver' | grep -v grep)" ] && [ -z "$(pidof postgres)" ]; then
    su - gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && timeout -s 9 20s gpstart -a"
fi

#        if [ $? =  $OCF_SUCCESS ]; then
#            touch ${OCF_RESKEY_state}
#            return $OCF_SUCCESS
#        else
#            return $OCF_ERR_GENERIC
#        fi
#    else
#    fi

    exit

#        su - gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && export PGPORT=5432 && gpactivatestandby -f -a -d /data/master/gpseg-1"
#        if [ $? =  $OCF_SUCCESS ]; then
#            touch ${OCF_RESKEY_state}
#            return $OCF_SUCCESS
#        else
#            return $OCF_ERR_GENERIC
#        fi
#    fi
#
#    exit



                su - gpadmin -c "timeout -s 9 5s psql -h localhost -c \"select 100 from pg_database where datname='gpadmin'\""

		exit

                su - gpadmin -c "timeout -s 9 5s psql -h localhost -c \"select 100 from pg_database where datname='gpadmin' \"" \
                > /dev/null 2>&1



		exit

( su - gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && timeout -s 9 5s gpstop -a" ) \
|| \
( kill -9 $(ps -ef | grep -v grep | grep postgres | awk '{print $2}') )
echo $?

exit

( su - gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && timeout -s 9 10s gpstate -Q > /dev/null 2>&1" ) \
&& \
( su - gpadmin -c "timeout -s 9 10s psql -h localhost -c \"select 100 from pg_database where datname='gpadmin'\"" > /dev/null 2>&1 )
echo $?

exit

( su - gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && timeout -s 9 10s gpstop -a" )
if [ $? != 0 ]; then
   kill -9 $(ps -ef | grep -v grep | grep postgres | awk '{print $2}')
fi

exit

#

echo "test"
([ $? = 0 ] && ( echo "kill" ))
echo $?

# if echo "kill"; 

# echo $?
#       	kill -9 $(ps -ef | grep -v grep | grep gpccws | awk '{print $2}')


( su - gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && timeout -s 9 10s gpstate -e > /dev/null 2>&1" ) \
&& \
( su - gpadmin -c "timeout -s 9 10s psql -h localhost -c \"select 100 from pg_database where datname='gpadmin'\"" > /dev/null 2>&1 )
echo $?

#        ( curl -I --insecure --connect-timeout 5 https://localhost:28080 > /dev/null 2>&1 )


