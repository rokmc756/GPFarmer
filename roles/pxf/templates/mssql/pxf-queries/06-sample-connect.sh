#!/bin/bash
#
export MSSQL_SA_PASSWORD="Changeme12!@"
export USER_PASSWORD="Changeme!@#$"
SQLCMD_DIR=/opt/mssql-tools/bin

$SQLCMD_DIR/sqlcmd -S 192.168.0.154 -U mssqluser -d testdb -P "$USER_PASSWORD" -i /root/pxf-queries/sqls/06-sample-connect.sql

