#!/bin/bash 
#输出1到10000以内所有的素数
ans=0
for (( i=2;i<=10000;i++ )) do
    flag=1;
    for (( j=2;j*j<=i;j++ )) do
        if [[ i%j -eq 0 ]]; then
            flag=0
            break
        fi
    done
    if [[ flag -eq 1 ]]; then
        ((ans++))
        echo $i
    fi
done
echo $ans
