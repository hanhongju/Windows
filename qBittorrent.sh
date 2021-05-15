# qBittorrent安装脚本 @ Debian 10
site=bt.hanhongju.com
apt   update
apt   install   -y   qbittorrent-nox
#为qbittorrent-nox创建一个systemd服务文件
echo   ' 
[Unit]
Description=qBittorrent Command Line Client
After=network.target
[Service]
#Do not change to "simple"
Type=forking
User=root
Group=root
UMask=007
ExecStart=/usr/bin/qbittorrent-nox -d
Restart=on-failure
[Install]
WantedBy=multi-user.target
'        >          /etc/systemd/system/qbittorrent-nox.service
systemctl   enable    qbittorrent-nox
systemctl   restart   qbittorrent-nox
sleep       1s
ss         -plnt
#回显监听端口
#用户名admin密码adminadmin监听端口8080


