#!/bin/bash
#输入一个数,判断这个数是否是素数
while ((1)); do
    read -p "请输入一个数:" x
    flag=1;
    for (( j=2;j*j<=x;j++ )) do
        if [[ x%j -eq 0 ]]; then
            flag=0
            break
        fi
    done
    if [[ flag -eq 1 ]]; then
        echo $x" is a prime"
    else echo $x" is not a prime"
    fi
done
