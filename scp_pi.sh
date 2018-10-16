#!/bin/bash

for i in `seq 1 10`; do
    scp ./longest_3_str.sh sanjin@pi$i:.
    ssh sanjin@pi$i "bash ./longest_3_str.sh >./out.log"
    scp sanjin@pi$i:./out.log ./pi$i.out
done

touch ./pi.out
rm ./pi.out

for i in `seq 1 10`; do
    cat pi$i.out | awk '{print $1 " " $2 " " "pi"'''$i'''":"$3 " " $4}' >> ./pi.out
done

echo "*****************以下为程序运行结果***************************"
cat ./pi.out | sort -n -r | head -n 3 | awk '{printf("%-110s\t%s\t%s\n", $2, $3, $4)}'
