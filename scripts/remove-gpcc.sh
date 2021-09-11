#!/bin/bash

HOST_NAME="mdw6"

ssh gpadmin@$HOST_NAME "source /usr/local/greenplum-db/greenplum_path.sh && source /usr/local/greenplum-cc-web/gpcc_path.sh && gpcc stop;"
ssh gpadmin@$HOST_NAME "rm -rf /usr/local/greenplum-cc-web*;"

# su - gpadmin
# gpconfig -c gp_enable_gpperfmon -v off
# Remove or comment out the gpmon entries in pg_hba.conf. For example:

# local     gpperfmon     gpmon     md5
# host      gpperfmon     gpmon    0.0.0.0/0    md5

ssh gpadmin@$HOST_NAME "source /usr/local/greenplum-db/greenplum_path.sh && psql template1 -c 'DROP ROLE gpmon;';"
ssh gpadmin@$HOST_NAME "source /usr/local/greenplum-db/greenplum_path.sh && gpstop -ra;"

ssh gpadmin@$HOST_NAME "rm -rf $MASTER_DATA_DIRECTORY/gpperfmon/data/*;"
ssh gpadmin@$HOST_NAME "rm -rf $MASTER_DATA_DIRECTORY/gpperfmon/logs/*;"

ssh gpadmin@$HOST_NAME "source /usr/local/greenplum-db/greenplum_path.sh && dropdb gpperfmon;"

