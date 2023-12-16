source /usr/local/greenplum-db/greenplum_path.sh && \
daemonize $GPHOME/bin/gpss /home/gpadmin/gpss-base/gpss_config.json \
--verbose --log-dir /home/gpadmin/gpss-base/logs

source /usr/local/greenplum-db/greenplum_path.sh && \
gpsscli submit --verbose --name kafkajson2gp \
--gpss-port 50007 \
/home/gpadmin/gpss-base/jsonload_cfg.yaml

source /usr/local/greenplum-db/greenplum_path.sh && \
gpsscli list --verbose --all --gpss-port 50007

source /usr/local/greenplum-db/greenplum_path.sh && \
gpsscli start kafkajson2gp --verbose --gpss-port 50007

source /usr/local/greenplum-db/greenplum_path.sh && \
psql -d testdb -c "SELECT * FROM public.json_from_kafka;"

source /usr/local/greenplum-db/greenplum_path.sh && \
gpsscli status kafkajson2gp --gpss-port 50007
