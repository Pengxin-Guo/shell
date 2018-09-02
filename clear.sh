#!/bin/bash
#定期删除/home/gpx/trash中的文件

cd /home/gpx/trash                     #首先进入该目录
find -mtime +7 -exec rm -rf {} \;      #然后删除该目录下7天前的所有文件,包括其中的子目录
