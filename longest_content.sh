#!/bin/bash 
#search for the longest string

max_length=0    #最长字符串长度,初始化为0
max_file=""     #所在位置
word=""         #最长字符串内容
flag=1

function find_maxone() {
    words=`cat $1 | tr -s -c "a-zA-Z" "\n"`
    #words=`cat $1`
    for a in $words; do
        #temp_length=`echo -n $a | wc -c`
        temp_length=${#a}
        if [[ $temp_length -gt $max_length ]]; then
            max_length=$temp_length
            max_file=$1
            word=$a
            #echo $max_length
        fi
    done
}

function listFilrs() {    
    maxsize=1024
    #1st param, the dir name
    for file in `ls $1`; do
        flag=0
        if [[ -d "$1/$file" ]]; then                                 #如果是目录,则遍历目录下的所有文件
            listFilrs "$1/$file"
        elif [[ `du -s $1/$file|awk '{print $1}'` -gt $maxsize ]]; then
            #echo "$1/$file   文件大小大于1MB"
            continue                                                 #如果文件大小大于1MB,则跳过
        else
            file $1/$file | grep "executable" >/dev/null
            if [[ $? == 0 ]]; then
                continue                                             #如果是二进制文件，则跳过
            else 
                find_maxone $1/$file                                 #否则读取该文件内容　
            fi
        fi
    done
}


listFilrs $1

if [[ flag -eq 0 ]]; then
    echo "最长的字符串长度:"$max_length
    echo "最长字符串内容:"$word
    echo "最长的字符串所在的文件位置:"$max_file
else
    echo "该文件或目录不存在"
fi

