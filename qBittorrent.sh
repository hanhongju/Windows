#qBittorrent安装脚本@Debian 10
apt   update 
apt   install   -y     net-tools nginx qbittorrent-nox
#为qbittorrent-nox创建一个systemd服务文件
#echo可以创建文件，但不能创建路径
adduser --system --group  bt
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
systemctl   enable    qbittorrent-nox
systemctl   restart   qbittorrent-nox
#配置nginx反代qbittorrent
echo  '
server {
listen 80;
listen [::]:80;
location /      {
proxy_pass                 http://127.0.0.1:8080/;
proxy_http_version         1.1;
proxy_set_header           X-Forwarded-Host        $http_host;
http2_push_preload on;     #NGINX从1.13.9版本开始支持HTTP/2服务端推送
}
}
'            >               /etc/nginx/sites-enabled/default
service  nginx  restart
#配置完成，显示监听端口
sleep 1s
netstat  -plunt | grep 'qbittorrent\|nginx'
#用户名admin，密码adminadmin，默认下载目录/home/bt/Downloads/








