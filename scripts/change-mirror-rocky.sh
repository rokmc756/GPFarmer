#!/usr/bin/env bash

##
REPOS_FILES="AppStream BaseOS"

PARAM="hn"

#KAKAO="mirror.kakao.com\/centos"
NAVER="mirror.navercorp.com\/rocky"

if [ "$(id -u)" != "0" ]; then
   echo "'$0' must be run as root" 1>&2
   exit 1
fi

function  usage {
    echo "USAGE: $0 [OPTION] ";
    echo -e "\r\n-b : make backup file";
#    echo "-r[repostiroy.file] : specify yum repository file (default ${BASE_REPOS})"
#    echo "-k : use kakao mirror (${KAKAO})"
    echo "-n : use naver mirror (${NAVER})"

    exit 0;
}

REMOTE_REPOS=${NAVER}

releasever=$(cat /etc/redhat-release | tr -dc '0-9.'|cut -d \. -f1)
basearch=x86_64

while getopts $PARAM opt; do
    case $opt in
        r)
            echo "-r option was supplied. OPTARG: $OPTARG" >&2
            REMOTE_REPOS=$OPTARG;
            ;;
        k)
            echo "Using Kakao repository(${REPOS})." >&2
            REMOTE_REPOS=${KAKAO}
            ;;
        n)
            echo "Using naver repository(${NAVER})." >&2
            REMOTE_REPOS=${NAVER}
            ;;
        h)
            usage;
             ;;
    esac
done

for i in ${REPOS_FILES};do
    R="/etc/yum.repos.d/Rocky-${i}.repo";

    FULL_REPOS_PATH="http:\/\/${REMOTE_REPOS}\/${releasever}\/${i}\/${basearch}\/os"

    if [ ! -f ${R} ];then
        continue;
    fi

    echo "using repository(${R})";

    ## change mirror
    sed  -i.bak -re "s/^(mirrorlist(.*))/##\1/g" -re "s/[#]*baseurl(.*)/baseurl=${FULL_REPOS_PATH}/" ${R}
done

## check
yum check-update
yum repolist baseos -v
yum repolist appstream -v

