#!/bin/bash
#检测恶意进程，在5s内如果某一进程的CPU或者内存占用超过50%，视为恶意进程

data=`top -c | head -n 10 | awk 'NR == 8 {print}'`    #data代表top显示出的第一个进程信息
pid=`echo $date | cut -d " " -f 2`                    #pid代表这个进程的ID
cpu=`echo $date | cut -d " " -f 10`                   #cpu代表这个进程的cpu占用

echo $cou $mem
if [ `echo "$cpu > 50" | bc` -eq 1 ];then
    sleep 5
    data=`top -p $pid -n 1 | awk 'NR == 8 {print}'`
    cpu=`echo $date | cut -d " " -f 10`                  
    mem=`echo $date | cut -d " " -f 10`
    if [ `echo "$cpu > 50" | bc` -eq 1 ];then
        date=`date +"%Y-%m-%d__%T"`
        pname=`echo $data | cut -d " " -f 13`
        user=`echo $data | cut -d " " -f 3`
        echo $date $pname $pid $user ${CPU}% ${mem}%
    fi
fi

