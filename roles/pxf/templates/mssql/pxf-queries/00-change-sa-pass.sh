#!/bin/bash
#
systemctl stop mssql-server

export MSSQL_SA_PASSWORD="Changeme12!@" && /opt/mssql/bin/mssql-conf set-sa-password

systemctl start mssql-server
