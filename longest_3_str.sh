#!/bin/bash 
#search for the longest_3 string

max1_str=(0 "" "" 0)      #最长字符串存储的内容，字符串长度、字符串内容、所在文件位置、行号
max2_str=(0 "" "" 0)      #第二长字符串存储的内容
max3_str=(0 "" "" 0)      #第三长字符串存储的内容
flag=1
num=1

function filter() {                                                  #过滤一些不需要考虑的文件
    suff=(rmvb png img jpg jpeg gif md avi zip tar gz 7z)
    suffix=`echo $1 | tr "." "\n" | tail -n 1`
    echo ${suff[*]} | grep "$suffix" >/dev/null
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
    if [[ ${max1_str[0]} -lt ${max2_str[0]} ]]; then
        temp=(${max1_str[*]})
        max1_str=(${max2_str[*]})
        max2_str=(${temp[*]})
    fi
    if [[ ${max1_str[0]} -lt ${max3_str[0]} ]]; then
        temp=(${max1_str[*]})
        max1_str=(${max3_str[*]})
        max3_str=(${temp[*]})
    fi
    if [[ ${max2_str[0]} -lt ${max3_str[0]} ]]; then
        temp=(${max2_str[*]})
        max2_str=(${max3_str[*]})
        max3_str=(${temp[*]})
    fi
}

function find_top3() {
    words=`cat "$1" | tr -s -c "a-zA-Z0-9" "\n"`
    #words=`cat $1`
    for a in $words; do
        #temp_length=`echo -n $a | wc -c`
        temp_length=${#a}
        line=`cat -n $1 | grep $a | awk '{print $1}' 2>/dev/null`
        temp=($temp_length "$a" "$1" $line)
        if [[ $num -le 3 ]];then
            if [[ $num -eq 1 ]]; then
                max1_str=(${temp[*]})
            elif [[ $num -eq 2 ]]; then
                max2_str=(${temp[*]})
            else
                max3_str=(${temp[*]})
                sort_data
            fi
        else
            if [[ $temp_length -gt ${max3_str[0]} ]]; then
                max3_str=(${temp[*]})
                sort_data
            fi
        fi
        num=$((num+1))
    done
}

function listFiles() {    
    maxsize=1024
    #1st param, the dir name
    OLDIFS=$IFS
    IFS=$'\n'
    for file in `ls -A $1`; do
        flag=0
        if [[ -d "$1/$file" ]]; then                                 #如果是目录,则遍历目录下的所有文件
            listFiles "$1/$file"
        else
            filter $1/$file                                          #判断该文件是否是待过滤文件
            if [[ $? == 0 ]]; then
                find_top3 $1/$file                                   #读取该文件内容
            fi
        fi
    done
    IFS=$OLDIFS
}

listFiles .

if [[ flag -eq 0 ]]; then
    echo ${max1_str[*]}
    echo ${max2_str[*]}
    echo ${max3_str[*]}
else
    echo "该文件或目录不存在"
fi

