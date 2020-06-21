#shadowsocks服务器安装脚本@Archlinux
yes   |   pacman   -Sy     archlinux-keyring
yes   |   pacman   -Syu
yes   |   pacman   -S      shadowsocks-libev
#创建shadowsocks-server配置文件
mkdir   /etc/shadowsocks/
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
'     >           /etc/shadowsocks/root.json
#启动服务
systemctl   enable    shadowsocks-libev-server@root.service
systemctl   restart   shadowsocks-libev-server@root.service
sleep 1s
netstat -tulpna | grep 'ss-server'
#回显ss-server监听端口



error: failed to commit transaction (conflicting files) stfl: /usr/lib/libstfl.so.0 exists in filesystem
pacman -Syu --overwrite /usr/lib/libstfl.so.0



#v2rayserver安装脚本@Archlinux
#定义网站地址
site=domain
#安装常用软件包：
yes   |   pacman   -Sy     archlinux-keyring
yes   |   pacman   -Syu
yes   |   pacman   -S      v2ray certbot nginx ntp wget curl net-tools linux-lts
#申请SSL证书
certbot     certonly    --standalone    --agree-tos   -n     -d    $site     -m    86606682@qq.com 
#配置证书自动更新
echo "0 0 1 */2 * service nginx stop; certbot renew; service nginx start;" | crontab -
crontab -l
#修改系统控制文件启用BBR
echo "tcp_bbr" > /etc/modules-load.d/80-bbr.conf
echo "net.ipv4.tcp_congestion_control=bbr" > /etc/sysctl.d/80-bbr.conf
sysctl   -p
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
'         >          /etc/v2ray/config.json
#创建nginx配置文件
echo '
events {
worker_connections  1024;
}
http {
sendfile on;
keepalive_timeout  65;
server{
server_name www.example.com;
set $proxy_name pubmed.ncbi.nlm.nih.gov;
listen 80;
listen [::]:80;
listen 443 ssl;
listen [::]:443 ssl;
resolver 8.8.8.8 8.8.4.4 valid=300s;
ssl_certificate          /etc/letsencrypt/live/www.example.com/fullchain.pem;  
ssl_certificate_key      /etc/letsencrypt/live/www.example.com/privkey.pem;   
if ( $scheme = http ){
return 301 https://$server_name$request_uri;
}
location /         {           #设置反代网站
sub_filter   $proxy_name   $server_name;
sub_filter_once off;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Referer https://$proxy_name;
proxy_set_header Host $proxy_name;
proxy_pass https://$proxy_name;
proxy_set_header Accept-Encoding "";
}
location /f63lKAx   {          #设置v2ray转发
proxy_pass http://127.0.0.1:8964;
proxy_redirect off;
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_set_header Host $host;
}
}
}
'         >       /etc/nginx/nginx.conf
sed      -i     ''s/www.example.com/$site/g''       /etc/nginx/nginx.conf
#启动V2Ray和Nginx：
systemctl   enable    v2ray.service
systemctl   enable    nginx.service
systemctl   restart   v2ray.service
systemctl   restart   nginx.service
#验证配置文件，显示监听端口
/usr/bin/v2ray     -test       -config=/etc/v2ray/config.json
nginx    -t
netstat  -tulpna | grep 'nginx'
#至此V2Ray可正常工作





