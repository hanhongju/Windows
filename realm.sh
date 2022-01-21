# realm端口转发代理 @ Debian 10
apt      -y      update    
apt      -y      install      wget
wget     -c      https://github.com/zhboner/realm/releases/download/v1.4/realm    -P    /usr/bin/
echo '
{
    "listening_addresses": ["0.0.0.0"],
    "listening_ports": ["8000-8020"],
    "remote_addresses": ["bm.huobipool.com"],
    "remote_ports": ["1800"]
}
'            >            /var/realm.conf
echo   ' 
[Unit]
Description=port relay
[Service]
Type=simple
ExecStart=/usr/bin/realm    -c    /var/realm.conf
Restart=on-failure
[Install]
WantedBy=multi-user.target
'             >            /etc/systemd/system/realm.service
systemctl     daemon-reload
systemctl     enable       realm
systemctl     restart      realm





