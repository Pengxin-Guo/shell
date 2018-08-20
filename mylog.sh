#!/bin/bash 
# 自动记录用户登录登出信息

echo "# 记录用户登录信息" >> /home/gpx/.bashrc  
cat >> /home/gpx/.bashrc << EOF
TIME_NOW=\`date +"%Y-%m-%d %H:%M"\`
USER_NOW=\`whoami\`
LOGIN_TIME=\`date +%s\`
echo "\$TIME_NOW \$USER_NOW LOGIN" >> /home/gpx/trash/mylog.log 
EOF

echo "# 记录用户登出信息" >> /home/gpx/.bash_logout 
cat >> /home/gpx/.bash_logout << EOF
TIME_NOW=\`date +"%Y-%m-%d %H:%M"\`
USER_NOW=\`whoami\`
LOGOUT_TIME=\`date +%s\`
echo "\$TIME_NOW \$USER_NOW LOGOUT last \$[(\$LOGIN_TIME-\$LOGOUT_TIME)/60] minute(s)" >> /home/gpx/trash/mylog.log 
EOF


