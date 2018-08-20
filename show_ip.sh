#!/bin/bash 
# 查询一个局域网中在线的ip
ip=192.168.1.
for i in `seq $1 $2`; do
    ping=`ping -c 2 -W 1 $ip$i`
    if [[ $? -eq 0 ]]; then
        echo $ip$i
    fi
done

