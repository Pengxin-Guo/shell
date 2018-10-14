#!/bin/bash 
#search for the longest_3 string

max1_str=(0 "" "")      #最长字符串存储的内容，字符串长度、字符串内容、所在文件
max2_str=(0 "" "")      #第二长字符串存储的内容
max3_str=(0 "" "")      #第三长字符串存储的内容
flag=1
num=0

function filter() {                                                  #过滤一些不需要考虑的文件
    suff=(rmvb png img jpg jpeg gif md avi zip tar gz 7z)
    suffix=`echo $1 | tr "." "\n" | tail -n 1`
    echo ${a[*]} | grep "$suffix" >/dev/null
    if [[ $? == 0 ]]; then
        return 1
    fi
    file $1 | grep "executable" >/dev/null 
    if [[ $? == 0 ]]; then
        return 1
    fi
    return 0
}

function sort_data() {
    if [[ ${max1_str[0]} < ${max2_str[0]} ]]; then
        temp=${max1_str[*]}
        max1_str=${max2_str[*]}
        max2_str=${temp[*]}
    fi
    if [[ ${max1_str[0]} < ${max3_str[0]} ]]; then
        temp=${max1_str[*]}
        max1_str=${max3_str[*]}
        max3_str=${temp[*]}
    fi　
    if [[ ${max2_str[0]} < ${max3_str[0]} ]]; then
        temp=${max2_str[*]}
        max2_str=${max3_str[*]}
        max3_str=${temp[*]}
    fi 
}

function find_top3() {
    words=`cat $1 | tr -s -c "a-zA-Z" "\n"`
    #words=`cat $1`
    for a in $words; do
        #temp_length=`echo -n $a | wc -c`
        temp_length=${#a}
        if [[ $num < 3 ]];then
            max_length[$num]=$temp_length
            max_file[$num]=$1
            word[$num]=$a
        elif [[ $num == 3 ]];then
            sort_data
        else
            if [[ $temp_length > ${max3_str[0]} ]]; then
                temp=($temp_length "$a" "$1")
                $max3_str=${temp[*]}
                sort_data
            fi
        fi
        num=$((num+1))
    done
}

function listFiles() {    
    maxsize=1024
    #1st param, the dir name
    for file in `ls $1`; do
        flag=0
        if [[ -d "$1/$file" ]]; then                                 #如果是目录,则遍历目录下的所有文件
            listFilrs "$1/$file"
        else
            filter $1/$file                                          #判断该文件是否是待过滤文件
            if [[ $? == 0 ]]; then
                find_top3 $1/$file                                   #读取该文件内容
            fi
        fi
    done
}

listFiles $1

if [[ flag -eq 0 ]]; then
    echo ${max1_str[*]}
    echo ${max2_str[*]}
    echo ${max3_str[*]}
else
    echo "该文件或目录不存在"
fi
