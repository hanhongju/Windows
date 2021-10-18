# qBittorrent安装脚本 @ Debian 10
apt     -y    update
apt     -y    install     qbittorrent-nox
#为qbittorrent-nox创建一个systemd服务文件
echo   ' 
[Unit]
Description=qBittorrent Command Line Client
After=network.target
[Service]
#Do not change to "simple"
Type=forking
ExecStart=/usr/bin/qbittorrent-nox -d --webui-port=8088
Restart=always
[Install]
WantedBy=multi-user.target
'        >          /etc/systemd/system/qbittorrent-nox.service
#启用服务
systemctl   enable    qbittorrent-nox
systemctl   restart   qbittorrent-nox
#网页端口8088，用户名admin，密码adminadmin，默认下载目录/Downloads/






