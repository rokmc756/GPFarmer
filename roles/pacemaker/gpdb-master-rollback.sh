su - gpadmin -c "mv /data/master/gpseg-1/recovery.done /data/master/gpseg-1/recovery.conf"
su - gpadmin -c "export PGPORT=5432 && gpactivatestandby -d /data/master/gpseg-1/ -f"
su - gpadmin -c "gpinitstandby -ra"
su - gpadmin -c "gpinitstandby -a -s rk8-slave"
