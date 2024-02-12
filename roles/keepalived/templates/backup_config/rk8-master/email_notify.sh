#!/bin/bash

echo "Keepalived state change! $1 $2 now has state $3" | wall
echo "Keepalived on $HOSTNAME changed state! $1 $2 now has state $3" | mail -s '[LOADBALANCER] Keepalived state change' root@localhost

