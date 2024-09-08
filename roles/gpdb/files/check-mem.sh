
action plan:
start the gptext via gptext-start
monitor the memory usage via
 source <GPTEXT_HOME>/greenplum-text_path.sh
for i in `cat $MASTER_DATA_DIRECTORY/gptext.conf | grep -v "^id"`; do host=`echo $i |awk -F',' '{print $2}'`; solr_home=`echo $i |awk -F',' '{print $4}'`; echo $host;  ssh $host "SOLR_INCLUDE=${solr_home}/solr.in.sh ${GPTXTHOME}/../greenplum-solr/bin/solr status 2>/dev/null" | egrep "solr_home|memory"; done

9:24
if only 1 solr process reached 100% memory usage, then consult with R&D if we need tune the xmax in solr config
9:25
if all node reach 100% then might check with R&D to confirm the reason
9:25
example output
[gpadmin@gp-aio-01][~]$ for i in `cat $MASTER_DATA_DIRECTORY/gptext.conf | grep -v "^id"`; do host=`echo $i |awk -F',' '{print $2}'`; solr_home=`echo $i |awk -F',' '{print $4}'`; echo $host;  ssh $host "SOLR_INCLUDE=${solr_home}/solr.in.sh ${GPTXTHOME}/../greenplum-solr/bin/solr status 2>/dev/null" | egrep "solr_home|memory"; done
gp-aio-01
  "solr_home":"/data/gptext/primary2/solr0/data",
  "memory":"103.3 MB (%10.5) of 490.7 MB",
gp-aio-01
  "solr_home":"/data/gptext/primary1/solr0/data",
  "memory":"83.2 MB (%8.5) of 490.7 MB",

