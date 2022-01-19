#realm端口转发代理f2pool矿池 @ Debian 10
apt      -y      update    
apt      -y      install      wget
wget    -c   https://github.com/zhboner/realm/releases/download/v1.4/realm    -P    /usr/bin/
#配置服务，启动服务器
echo   ' 
[Unit]
Description=relay to f2pool
[Service]
Type=simple
ExecStart=/usr/bin/realm -l 0.0.0.0:8000-9000 -r eth.f2pool.com:6688 
Restart=on-failure
[Install]
WantedBy=multi-user.target
'             >            /etc/systemd/system/realm.service
systemctl     daemon-reload
systemctl     enable       realm
systemctl     restart      realm





