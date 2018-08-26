#!/bin/bash
date=`date +"%Y-%m-%d__%T"`           #date代表当前时间
hostname=`uname -n`                   #hostname代表主机名
osname=`uname -o`                     #osname代表OS版本
kernel_version=`uname -m | cut -d " " -f 3`  #kernel_version代表内核版本
run_time=`uptime -p | tr " " ","`     #run_time代表运行时间
aver_load=`uptime | cut -d ":" -f 5 | tr "," " "` #aver_load代表平均负载

