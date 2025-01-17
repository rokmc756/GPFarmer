# vi change-log-min.sh
# for i in `grep -r 'log_min_messages=none' /data`
# do
#   sed -i -e 's/log_min_messages=none/log_min_messages=info/g' $(echo $i | cut -d : -f 1)
#   cat $(echo $i | cut -d : -f 1)
# done

# gpscp -f hostfile_all change-log-min.sh =:/home/gpadmin
# gpscp -h sdw1 -h sdw2 myfuncs.so =:/home/gpadmin

# gpssh -f hostfile_all -e "sh /home/gpadmin/change-log-min.sh"
