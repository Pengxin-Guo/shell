#!/bin/bash
path=`w -h | awk '{print $2}'`
who=`whoami`
for i in $path; do
    echo from $who to every : $1 >> /dev/$i 
done

