#!/bin/bash
#

GPDB_PID_FILE='/data/master/gpseg-1/postmaster.pid'
GPDB_PORT='5432'
GPDB_USER='gpadmin'
GPDB_HOST='192.168.0.172'
GPDB_LOCALIP="${1:-127.0.0.1}"
GPDB_REMOTEIP="${2:-127.0.0.1}"
LOG='/var/log/check-gpdb-vrrp.log'

. /etc/keepalived/functions-common.sh || exit 1
. /etc/keepalived/functions-gpdb.sh || exit 1

# Local GPDB checks
check_pid_file "${GPDB_PID_FILE}" || exit_err 'pid_file' 1
check_listen_port "${GPDB_PORT}" || exit_err 'listen_port' 1
check_gpdb_connect "${GPDB_LOCALIP}" || exit_err 'gpdb_connect: Connect failure' 1
exit 0
