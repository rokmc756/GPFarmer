#!/bin/bash
for i in `seq 161 165`; do ssh gpadmin@192.168.0.$i sudo shutdown -h now ; done
