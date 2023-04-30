#!/bin/bash

echo "[ Database Size ]"
psql -d testdb -c "SELECT sodddatname, (sodddatsize/1048576) AS sizeinMB FROM gp_toolkit.gp_size_of_database where sodddatname='testdb';"
echo ""

echo "[ Table Size ]"
psql -d testdb -c "SELECT pg_size_pretty(pg_relation_size('public.countries'));"
echo ""
