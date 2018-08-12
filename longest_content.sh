#!/bin/bash 
#search for the longest string

max_length=0
max_file=""
word=""

function find_maxone() {
    #words=`cat $1 | tr -s -c "a-zA-Z" "\n"`
    words=`cat $1`
    for a in $words; do
        #temp_length=`echo -n $a | wc -c`
        temp_length=${#a}
        if [[ $temp_length -gt $max_length ]]; then
            max_length=$temp_length
            max_file=$1
            word=$a
            echo $max_length
        fi
    done
}

function listFilrs() {
    maxsize=1024
    #1st param, the dir name
    for file in `ls $1`; do
        if [[ -d "$1/$file" ]]; then
            #echo "$file"
            listFilrs "$1/$file"
        elif [[ `du -s $1/$file|awk '{print $1}'` -gt $maxsize ]]; then
            #echo "$1/$file   文件大小大于1MB"
            continue
        else
            #echo "$file"
            find_maxone $1/$file
        fi
    done
}

listFilrs "/home/gpx"
echo "最长的字符串长度:"$max_length
echo "最长的字符串所在的文件位置:"$max_file
echo "最长的字符串内容:"$word

