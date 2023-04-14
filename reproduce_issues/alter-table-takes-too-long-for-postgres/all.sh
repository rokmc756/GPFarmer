cp *.sql /var/lib/pgsql/
chown postgres.postgres /var/lib/pgsql/
chown postgres.postgres /var/lib/pgsql/*.sql

#su - postgres -c "dropdb testdb"
#su - postgres -c "createdb testdb"
#su - postgres -c "psql -d testdb -f 01-create-table.sql"
su - postgres -c "psql -d testdb -f 02-insert-data.sql"
#su - postgres -c "psql -d testdb -f 03-alter-table.sql"

