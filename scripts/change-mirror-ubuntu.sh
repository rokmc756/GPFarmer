#!/bini/bash   
#
HOSTS_RANGE="41 45"
NETWORK_RANGE="192.168.0"
USER="root"

for i in `seq $HOSTS_RANGE`
do

    ssh $USER@$NETWORK_RANGE.$i "
        chmod +x /root/change-ubuntu-mirror.sh ;
        /root/change-ubuntu-mirror.sh -n
    "
done
#  wget https://gist.githubusercontent.com/lesstif/8185f143ba7b8881e767900b1c8e98ad/raw/b749a8fc590ad2391fd0f8849417eeec998b33a7/change-ubuntu-mirror.sh ;
#  /root/change-ubuntu-mirror.sh -k  # Kakao
# ./change-ubuntu-mirror.sh -n; # Kaist Univ
# ./root/change-ubuntu-mirror.sh -a  # Bukyeong Univ
