#!/bin/bash 
# 实现广播功能
path=`w -h | awk '{print $2}'`
who=`whoami`
for i in $path; do
    echo from $who to every one \(`date`\): $1 >> /dev/$i 
done

