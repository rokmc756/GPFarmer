for i in `seq 1 5`
do

    nc -vz 192.168.2.19$i 22
    # ssh-keyscan 192.168.2.18$i
    ssh-keyscan 192.168.2.19$i >/dev/null 2>&1

done

