#!/bin/bash

# RANGE="81 85"
# RANGE="51 55"
# RANGE="41 45"
RANGE="61 65"
#RANGE="171 175"
USER="gpadmin"

for i in `seq $RANGE`
do
    ssh $USER@192.168.0.$i "killall postgres; rm -f /tmp/*5432*"
    ssh $USER@192.168.0.$i "ps -ef | grep postgres | grep -v grep | wc -l ; ls -al /tmp/*5432*"
done
