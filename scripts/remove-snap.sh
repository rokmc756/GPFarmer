#!/bin/bash

for i in `snap list | awk '{print $1}' | tail -n +2`; do snap remove $i; done
for i in `mount -l | grep snap | awk '{print $3}'`; do umount $i; done

umount /var/snap
apt purge snapd -y
rm -rf ~/snap /snap /var/snap /var/lib/snapd

systemctl stop snapd
systemctl disable snapd

exit

#rm -rf ~/snap
#m -rf /var/cache/snapd
#apt purge snapd
#
#systemctl stop snapd
#systemctl disable snapd
#
#snap remove base
#
#snap list --all | while read snapname ver rev trk pub notes; do if [[ $notes = *disabled* ]]; then snap remove "$snapname" --revision="$rev"; fi; done

for i in `mount -l | grep snap | awk '{print $3}'`; do umount $i ;done
for i in `snap list | tail -n +2 | awk '{print $1}'`; do snap remove $i ;done


mount -l | grep snap

snap set system refresh.retain=2
snap refresh
umount /snap/core/14946
