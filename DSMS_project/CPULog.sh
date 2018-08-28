#!/bin/bash
date=`date +"%Y-%d-%m__%T"`    #date代表当前时间
load=`cat /proc/loadavg | cut -d " " -f 1-3`  #load代表3个负载负载
#cat /proc/loadavg 中
#前三个值分别代表系统5分钟、10分钟、15分钟前的平均负载
#第四个值的分子是正在运行的进程数，分母为总进程数
#第五个值是最近运行的进程id
