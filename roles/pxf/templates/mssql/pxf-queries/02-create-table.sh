#!/bin/bash
#
export MSSQL_SA_PASSWORD="Changeme12!@"
SQLCMD_DIR=/opt/mssql-tools/bin

$SQLCMD_DIR/sqlcmd -S localhost -U SA -P "$MSSQL_SA_PASSWORD" -i /root/pxf-queries/sqls/02-create-table.sql
