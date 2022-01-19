# realm端口转发代理f2pool矿池 @ Debian 10
apt      -y      update    
apt      -y      install      wget
wget     -c      https://github.com/zhboner/realm/releases/download/v1.4/realm    -P    /usr/bin/
echo '
{
    "listening_addresses": ["0.0.0.0"],
    "listening_ports": ["8000-8020"],
    "remote_addresses": ["eth.f2pool.com"],
    "remote_ports": ["6688"]
}
'        >           /home/realm.conf
#配置服务，启动服务器
echo   ' 
[Unit]
Description=relay to f2pool
[Service]
Type=simple
ExecStart=/usr/bin/realm   -c    /home/realm.conf
Restart=on-failure
[Install]
WantedBy=multi-user.target
'             >            /etc/systemd/system/realm.service
systemctl     daemon-reload
systemctl     enable       realm
systemctl     restart      realm





