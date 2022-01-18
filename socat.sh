#socat端口转发代理f2pool矿池 @ Debian 10
apt     -y    update
apt     -y    install     socat
#配置服务，启动服务器
echo   ' 
[Unit]
Description=qBittorrent Command Line Client
After=network.target
[Service]
Type=simple
ExecStart=/usr/bin/socat TCP-LISTEN:6688,fork TCP:eth.f2pool.com:6688 
Restart=on-failure
[Install]
WantedBy=multi-user.target
'           >          /etc/systemd/system/socat.service
systemctl   daemon-reload
systemctl   enable     socat
systemctl   restart    socat





