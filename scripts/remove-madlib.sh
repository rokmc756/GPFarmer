#!/bin/bash

HOST_NAME=mdw4
DBNAME=testdb
ssh gpadmin@$HOST_NAME "source /usr/local/greenplum-db/greenplum_path.sh; dropdb $DBNAME;
/usr/local/greenplum-db/madlib/bin/madpack uninstall -s madlib -p greenplum -c gpadmin@$HOST_NAME:5432/$DBNAME;
psql -c \"drop schema madlib cascade;\";
export madlib_pkgname=$(/usr/local/greenplum-db/bin/gppkg -q --all | tail -1);
/usr/local/greenplum-db/bin/gppkg -r $madlib_pkgname
/usr/local/greenplum-db/bin/gppkg -q --all
rm -rf /usr/local/greenplum-db/madlib
"
