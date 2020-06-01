#v2ray安装脚本@Debian 10
#定义网站地址
site=domain
#安装常用软件包：
apt update
apt full-upgrade  -y
apt autoremove    -y
apt install       -y  python3-pip wget curl policycoreutils nginx net-tools curl ntp ntpdate shadowsocks-libev php-fpm php-mysql 
#安装Certbot和V2Ray
pip3 install cryptography --upgrade
pip3 install certbot && bash -c "$(curl -L -s https://install.direct/go.sh)"
#修改shadowsocks配置
echo '
{
    "server":["[::0]", "0.0.0.0"],
    "mode":"tcp_and_udp",
    "server_port":3389,
    "local_port":1080,
    "password":"fengkuang",
    "timeout":60,
    "method":"aes-256-gcm"
}
'     >           /etc/shadowsocks-libev/config.json
#修改v2ray配置
echo '
{
      "inbound":{ 
                 "protocol": "vmess",
                 "listen": "127.0.0.1",
                 "port": 8964,
                 "settings": {
                                 "clients": [{"id": "15448fce-7c71-11ea-bc55-0242ac130003"}]
                 },
                 "streamSettings": {
                                "network": "ws",
                                "wsSettings": {"path": "/f63lKAx"}
                 }
        },
        "outbound": {"protocol": "freedom"}
}
'     >          /etc/v2ray/config.json
#申请SSL证书
service nginx stop
certbot certonly --standalone --agree-tos -n  -d    $site    -m 86606682@qq.com 
ln -s  /etc/letsencrypt/live/$site/fullchain.pem        /etc/letsencrypt/live/fullchain.pem
ln -s  /etc/letsencrypt/live/$site/privkey.pem          /etc/letsencrypt/live/privkey.pem
#配置证书自动更新
echo "0 0 1 */2 * service nginx stop; certbot renew; service nginx start;" | crontab
#关闭SELinux
setsebool -P httpd_can_network_connect 1 && setenforce 0
#下载探针
# wget命令参数   -O不会创建目录    -P可以创建深层次目录
mkdir    /home/website
wget     https://raw.githubusercontent.com/kmvan/x-prober/master/dist/prober.php      -O     /home/website/p.php
#创建nginx配置文件
echo '
server{
server_name www.example.com;
set $proxy_name pubmed.ncbi.nlm.nih.gov;
listen 80;
listen [::]:80;
listen 443 ssl;
listen [::]:443 ssl;
ssl_certificate       /etc/letsencrypt/live/fullchain.pem;  
ssl_certificate_key   /etc/letsencrypt/live/privkey.pem;   
resolver 8.8.8.8 8.8.4.4 valid=300s;
if ( $scheme = http ){
return 301 https://$server_name$request_uri;
}
root      /home/website/;
index     index.php index.html index.htm;
location /   {
sub_filter   $proxy_name   $server_name;
sub_filter_once off;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Referer https://$proxy_name;
proxy_set_header Host $proxy_name;
proxy_pass https://$proxy_name;
proxy_set_header Accept-Encoding "";
}
location /f63lKAx{      
proxy_pass http://127.0.0.1:8964;
proxy_redirect off;
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_set_header Host $host;
}
location ~ \.php$ {
fastcgi_pass  unix:/run/php/php7.3-fpm.sock;          #php -v 遇到502 Bad Gateway时查看php版本，确认php-fpm.sock版本
fastcgi_index  index.php;
fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
include        fastcgi_params;
}
location /qbt/ {                       #反代qBittorrent网页客户端
proxy_pass              http://127.0.0.1:8080/;
proxy_http_version      1.1;
proxy_set_header        X-Forwarded-Host        $http_host;
http2_push_preload on;     #NGINX从1.13.9版本开始支持HTTP/2服务端推送
}
}
'     >      /etc/nginx/conf.d/default.conf
#修改nginx配置文件
sed -i     ''s/www.example.com/$site/g''       /etc/nginx/conf.d/default.conf
service nginx restart
#启动V2Ray和Nginx：
systemctl enable v2ray.service
systemctl enable nginx.service
service v2ray restart
service nginx restart
service shadowsocks-libev restart
#修改系统控制文件启用BBR
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
#检查目前BBR启动状态
sysctl net.ipv4.tcp_congestion_control
#验证配置文件，显示监听端口
/usr/bin/v2ray/v2ray -test -config=/etc/v2ray/config.json
nginx -t
netstat -tulpna | grep 'nginx\|ss-server'
#至此V2Ray可正常工作


