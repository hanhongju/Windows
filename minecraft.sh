# MineCraft JAVA版服务器搭建脚本 @ Debian
apt      -y      update    
apt      -y      install      wget default-jdk
#下载mc服务器1.16.5
wget     -c      https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar     -P     /home/mcserverjava/
#配置服务，启动服务器
echo     "eula=true"      >       /home/mcserverjava/eula.txt
echo   ' 
[Unit]
Description               =       Minecraft server
[Service]
#Do not change to "forking"
Type                      =       simple
WorkingDirectory          =       /home/mcserverjava/
ExecStart                 =       java     -jar    /home/mcserverjava/server.jar     nogui
Restart                   =       on-failure
[Install]
WantedBy                  =       multi-user.target
'                         >       /etc/systemd/system/mcserver.service
systemctl     daemon-reload
systemctl     restart      mcserver
ss            -plnt    |   awk 'NR>1 {print $4,$6}'   |   column   -t



#备份服务器
tar    -Pcf     /home/mcjava.tar      /home/mcserverjava/
#还原服务器
tar    -Pxf     /home/mcjava.tar



# 官网下载地址
# https://www.minecraft.net/zh-hans/download





