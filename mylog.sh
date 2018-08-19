#!/bin/bash 
echo "# 记录用户登录信息" >> /home/gpx/.bashrc  
cat >> /home/gpx/.bashrc << EOF
TIME_NOW=\`date -u +"%Y-%m-%d %H:%M"\`
USER_NOW=\`whoami\`
echo "\$TIME_NOW \$USER_NOW LOGIN" >> /home/gpx/trash/mylog.log 
EOF

echo "# 记录用户登出信息" >> /home/gpx/.bash_logout 
cat >> /home/gpx/.bash_logout << EOF
TIME_NOW=\`date -u +"%Y-%m-%d %H:%M"\`
USER_NOW=\`whoami\`
echo "\$TIME_NOW \$USER_NOW LOGOUT" >> /home/gpx/trash/mylog.log 
EOF


