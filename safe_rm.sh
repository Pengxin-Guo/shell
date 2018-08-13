#!/bin/bash
#safe rm shell

dir="/home/gpx/trash"
date=$(date "+%y-%m-%d-%T")  #date用于重命名重名的文件

#首先判断dir目录是否存在,不存在的话创建该目录
if [ ! -d $dir ];then
    mkdir -p $dir            #参数 -p 可以创建多级目录
fi

args=""       #用来存放待删除的文件路径(可能不止一个文件)
flag1=1       #用来判断要删除的是否是文件夹,1代表不是文件夹
flag2=1       #如果是文件夹的话判断是否可以递归删除,1代表没设置递归删除

function remove() {
    for file in ${args}; do
        if [ -d "$file" ];then      #file是目录
            files=`ls $file`
            if [ -z "$files" ]; then           #目录为空
                new_name="$dir/${file}_$date"
                mv $file $new_name && echo "$file deleted, you can see in $new_name"
            else                               #目录非空
                if [[ $flag1 == 1 ]];then               #没有设置删除目录
                    echo "can not remove $file:$file is a directoy"
                elif [[ $flag2 == 1 ]];then             #没有设置递归删除
                    echo "can not remove $file:$file is not a empty directoy"
                else                                    #设置了递归删除目录
                    new_name="$dir/${file}_$date"
                    mv $file $new_name && echo "$file deleted, you can see in $new_name"
                fi
            fi
        elif [ -f "$file" ];then    #file是文件
            new_name="$dir/${file}_$date"
            mv $file $new_name && echo "$file deleted, you can see in $new_name"      
        else
            echo "wrong param"
        fi
    done
}

while [ "$1" ]; do
    case "$1" in
        -fr|-rf)
            flag1=0
            flag2=0
            shift  #shift销毁第一个变量参数,第二个参数则变成第一个
            ;;
        -f)
            flag1=0
            shift
            ;;
        -r)
            flag2=0
            shift
            ;;
        -i)
            shift
            ;;
        *)
            args="$args $1"
            shift
            ;;
    esac
done

remove
