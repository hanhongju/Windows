# MineCraft JAVA版服务器搭建脚本 @ Debian
apt      -y      update    
apt      -y      install      wget default-jdk
#下载mc服务器1.18.2
wget     -c      https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar     -P     /home/mcserverjava/
#配置服务，启动服务器
echo   'eula=true'      >       /home/mcserverjava/eula.txt
echo   ' 
[Unit]
Description=Minecraft server
[Service]
Type=simple
WorkingDirectory=/home/mcserverjava/
ExecStart=java     -jar    /home/mcserverjava/server.jar     nogui
Restart=on-failure
[Install]
WantedBy=multi-user.target
'             >            /etc/systemd/system/mcserver.service
systemctl     daemon-reload
systemctl     enable       mcserver
systemctl     restart      mcserver



#备份服务器
tar    -cf      /home/mcjava.tar       -P      /home/mcserverjava/
#还原服务器
tar    -Pxf     /home/mcjava.tar



# 官网下载地址
# https://www.minecraft.net/zh-hans/download





