#!/usr/bin/env bash

# check GPDB connection and sample query
check_gpdb_connect() {
	local _res=`su gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && psql -U gpadmin -h '${1:-localhost}' -d gpadmin -q -t -c 'select 1;' | head -n 1 | tr -d ' '"`
	[[ $? -le 0 ]] && [[ "${_res}" = "1" ]] && return 0
	return 1
}

# returns 0 if master, otherwise 1
# It may need to modify for gpdb
check_gpdb_master() {
	local _res=`su gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh && psql -U gpadmin -h '${1:-localhost}' -d gpadmin -q -t -c 'select pg_is_in_recovery();' | head -n 1 | tr -d ' '"`
	[[ $? -le 0 ]] && [[ "${_res}" = "f" ]] && return 0
	return 1
}
