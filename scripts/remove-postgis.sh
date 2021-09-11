#!/bin/bash

HOST_NAME=mdw4
DBNAME=testdb
ssh gpadmin@$HOST_NAME "source /usr/local/greenplum-db/greenplum_path.sh;
export postgix_pkgname=$(/usr/local/greenplum-db/bin/gppkg -q --all | grep postgis);
/usr/local/greenplum-db/bin/gppkg -r $postgis_pkgname
/usr/local/greenplum-db/bin/gppkg -q --all
"
