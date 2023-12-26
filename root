#!/usr/bin/env bash

BASE_REPOS=/etc/yum.repos.d/CentOS-Linux-BaseOS.repo
PARAM="r:hkn"

KAKAO="mirror.kakao.com\/centos"
NAVER="mirror.navercorp.com\/centos"

if [ "$(id -u)" != "0" ]; then
   echo "'$0' must be run as root" 1>&2
   exit 1
fi

function  usage {
    echo "USAGE: $0 [OPTION] ";
    echo -e "\r\n-b : make backup file";
    echo "-r[repostiroy.file] : specify yum repository file (default ${BASE_REPOS})"
    echo "-k : use kakao mirror (${KAKAO})"
    echo "-n : use naver mirror (${NAVER})"

    exit 0;
}

REPOS=${KAKAO}

releasever=$(cat /etc/centos-release | tr -dc '0-9.'|cut -d \. -f1)
basearch=x86_64

while getopts $PARAM opt; do
    case $opt in
        r)
            echo "-r option was supplied. OPTARG: $OPTARG" >&2
            BASE_REPOS=$OPTARG;
            ;;
        k)
            echo "Using Kakao repository(${REPOS})." >&2
            REPOS=${KAKAO}
            ;;
        n)
            echo "Using naver repository(${NAVER})." >&2
            REPOS=${NAVER}
            ;;
        h)
            usage;
             ;;
    esac
done

FULL_REPOS="http:\/\/${REPOS}\/${releasever}\/BaseOS\/${basearch}\/os"

echo "using repository(${REPOS})"

## change mirror
sed  -i.bak -re "s/^(mirrorlist(.*))/##\1/g" -re "s/[#]*baseurl(.*)/baseurl=${FULL_REPOS}/" ${BASE_REPOS} 

## check
yum update
