apt     -y    update
apt     -y    install     qbittorrent-nox net-tools
echo   '
[Unit]
Description=qBittorrent Command Line Client
After=network.target
[Service]
Type=forking
ExecStart=/usr/bin/qbittorrent-nox -d --webui-port=8088
Restart=on-failure
[Install]
WantedBy=multi-user.target
'           >          /etc/systemd/system/qbittorrent-nox.service
systemctl   daemon-reload
systemctl   enable     qbittorrent-nox
systemctl   restart    qbittorrent-nox
netstat     -plnt
echo        "用户名admin，密码adminadmin，默认下载目录/Downloads/"




directsetup () {
apt    -y    install    wget
wget   https://github.com/hanhongju/my_script/raw/master/qBittorrent.sh    -O    setup.sh
bash   setup.sh

}




uninstall () {
systemctl     stop      qbittorrent-nox
systemctl     disable   qbittorrent-nox
netstat       -plnt

}




# qBittorrent安装脚本 @ Debian 10



