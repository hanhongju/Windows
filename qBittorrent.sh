# qBittorrent安装脚本 @ Debian 10
apt    update
apt    install   -y    qbittorrent-nox
adduser     bt   --system     --group
#为qbittorrent-nox创建一个systemd服务文件
echo   ' 
[Unit]
Description=qBittorrent Command Line Client
After=network.target
[Service]
#Do not change to "simple"
Type=forking
User=bt
Group=bt
UMask=007
ExecStart=/usr/bin/qbittorrent-nox -d --webui-port=8088
Restart=on-failure
[Install]
WantedBy=multi-user.target
'        >          /etc/systemd/system/qbittorrent-nox.service
#启用服务
systemctl   enable    qbittorrent-nox
systemctl   restart   qbittorrent-nox
sleep       1s
ss         -plnt
#网页端口8088，用户名admin，密码adminadmin，默认下载目录/home/bt/Downloads/





