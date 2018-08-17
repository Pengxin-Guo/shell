#!/bin/bash
# 找出一个目录下面文件和目录的个数,包括隐藏文件

num_file=0  #文件个数初始化为0
num_dir=0   #目录个数初始化为0

function search() {
    for file in `ls -a $1`;do
        if [[ $file == "." || $file == ".." ]];then
            continue
        elif [[ -d $1"/"$file ]];then
            ((num_dir++))
            search $1"/"$file
        else 
            ((num_file++))
        fi
    done
}

search $1

echo "文件个数为:" $num_file
echo "目录个数为:" $num_dir
