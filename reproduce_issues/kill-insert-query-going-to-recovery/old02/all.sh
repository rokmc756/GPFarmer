#!/bin/bash

dropdb testdb
createdb testdb

psql -d testdb -f ./01-create-table.sql

exit

# psql -d testdb -f ./02-insert-data.sql
# psql -d testdb -f ./03-alter-table.sql

