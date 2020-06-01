#  安装qBittorrent  @  Debian 10
apt   update 
apt   install  -y   qbittorrent-nox
#为qbittorrent-nox创建一个systemd服务文件
adduser --system --group  bt
#echo可以创建文件，但不能创建路径
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
ExecStart=/usr/bin/qbittorrent-nox -d
Restart=on-failure
[Install]
WantedBy=multi-user.target
'        >          /etc/systemd/system/qbittorrent-nox.service
systemctl daemon-reload
systemctl enable qbittorrent-nox
service  qbittorrent-nox    restart
#前端登录地址domain:8080。用户名admin，密码adminadmin，默认下载目录/home/bt/Downloads/
