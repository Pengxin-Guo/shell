#!/bin/bash
. /home/gpx/文档/Github/shell/auto_backup/.gpx_backup.rc    #首先执行配置文件

backup_path=` echo $backup_path | tr ":" "\n"`
TIME_NOW=`date +"%y-%m-%d %H:%M"`
TIME_FILE=`date +"%y_%m_%d_%H:%M"`

if [[ ! -d $dest_dir ]]; then
    echo -e "$TIME_NOW \033[37;31m[ERROR]\033[0m The Dest dir $dest_dir not exists" >> $log
    exit
fi 

echo -e "$TIME_NOW  \033[37;33m backup started! \033[0m" >> $log

for file_path in $backup_path; do
    if [[ ! -d $file_path ]]; then
        echo -e "$TIME_NOW backup \033[37;31m[ERROR]\033[0m The dir $file_path not exist" >> $log 
        continue 
    fi
    file_name=`echo $file_path | cut -d '/' -f "2-" | tr '/' '_'`
    file_name=${file_name}_${TIME_FILE}.tar.gz
    tar -czPf ${dest_dir}/${file_name} $file_path
    if [[ $? -eq 0 ]]; then
        size=`du -h ${dest_dir}/${file_name} | cut -f 1`
        echo -e "$TIME_NOW backup $file_path --> $file_name \033[37;33m+${size} \033[0m" >> $log
    else
        echo -e "$TIME_NOW \033[37;31m[ERROR]\033[0m tar $file_name failed" >> $log
    fi
done

Del_list=`find $dest_dir -name *.tar.gz -mtime +3`

for del_name in $Del_list; do
    size=`du -h ${del_name} | cut -f 1`
    rm -f $del_name
    echo -e "$TIME_NOW delete $del_name --> remove \033[37;33m-${size}\033[0m" >> $log
done

