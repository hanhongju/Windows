#qBittorrent安装脚本@Debian 10
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
#配置nginx反代qbittorrent
#删除nginx配置文件空白行
sed -i    '/^[[:blank:]]*$/d'     /etc/nginx/sites-enabled/default.conf
#删除nginx配置文件最后一行
sed -i        '$d'                      /etc/nginx/sites-enabled/default.conf
#追加配置
echo  '
location /bt/ {                       #反代qBittorrent网页客户端
proxy_pass              http://127.0.0.1:8080/;
proxy_http_version      1.1;
proxy_set_header        X-Forwarded-Host        $http_host;
http2_push_preload on;     #NGINX从1.13.9版本开始支持HTTP/2服务端推送
}
}
'            >>               /etc/nginx/sites-enabled/default.conf
#重启服务
service  nginx              restart
service  qbittorrent-nox    restart
#用户名admin，密码adminadmin，默认下载目录/home/bt/Downloads/
