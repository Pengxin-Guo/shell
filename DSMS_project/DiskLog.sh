#!/bin/bash
date=`date +"%Y-%m-%d__%T"`                  #date代表当前时间
eval `df -m | grep "^/dev" | awk '{printf("arr_total["NR"]=%d;arr_used["NR"]=%d;arr_percent["NR"]=%s;arr_path["NR"]=%s\n",$2,$3,$5,$6)}'`
total=0                                      #total代表磁盘总量
used=0                                       #used代表磁盘占用量

for i in `seq 1 ${#arr_total[@]}`;do
    total=$[$total+${arr_total[$i]}]
    used=$[$used+${arr_used[$i]}]
done

percent=$[$used*100/$total]                  #percent代表磁盘占用比例
remaining=$[$total-$used]                    #remaining代表磁盘剩余量

echo $date 0 disk $total $remaining ${percent}%
for i in `seq 1 ${#arr_total[@]}`;do
    echo $date 1 ${arr_path[$i]} ${arr_total[$i]} $[${arr_total[$i]}-${arr_used[$i]}] ${arr_percent[$i]}
done
