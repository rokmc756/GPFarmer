#!/bin/bash
echo $1 $2 is in $3 state > /var/run/keepalive.$1.$2.state
echo "4 : $4" >> /var/run/keepalive.$1.$2.state
echo "5 : $5" >> /var/run/keepalive.$1.$2.state
echo "6 : $6" >> /var/run/keepalive.$1.$2.state
echo "7 : $7" >> /var/run/keepalive.$1.$2.state
echo "8 : $8" >> /var/run/keepalive.$1.$2.state
echo "9 : $9" >> /var/run/keepalive.$1.$2.state

