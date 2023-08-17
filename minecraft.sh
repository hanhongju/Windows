apt      -y      update
apt      -y      install      wget default-jdk
wget     https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar     -cP     /home/mcserverjava/
echo     'eula=true'      >       /home/mcserverjava/eula.txt
echo     ' 
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




# MineCraft JAVA版服务器搭建脚本 @ Debian
# 官网下载地址
# https://www.minecraft.net/zh-hans/download/server





