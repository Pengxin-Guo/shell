#!/bin/bash
#检测恶意进程，在5s内如果某一进程的CPU或者内存占用超过50%，视为恶意进程

ps -aux | tr -s " " | sort -t" " -k 3 -r | head -n 10 | tail -n 9 > Process.txt
for i in `seq 1 9`;do
    data[$i]=$(awk 'NR == $i {print}' ./Process.txt)
done
for i in `seq 1 9`;do
    echo ${data[$i]};
done
