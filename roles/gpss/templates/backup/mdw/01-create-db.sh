createdb testdb
psql -d testdb -c "create extension gpss"
psql -d testdb -f ./create_table.sql
