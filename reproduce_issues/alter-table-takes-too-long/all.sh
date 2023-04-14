#!/bin/bash

dropdb testdb
createdb testdb

# psql -d testdb -f add_column_test.sql

exit

psql -d testdb -f ./02-insert-data.sql
psql -d testdb -f ./03-select-table.sql
psql -d testdb -f ./04-alter-table.sql

