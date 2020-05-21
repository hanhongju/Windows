#v2ray安装脚本@Debian 10
#定义网站地址
site=domain
#安装常用软件包：
apt update
apt install -y  python3-pip wget policycoreutils nginx net-tools curl ntp ntpdate shadowsocks-libev
#安装Certbot和V2Ray
pip3 install cryptography --upgrade
pip3 install certbot && bash -c "$(curl -L -s https://install.direct/go.sh)"
#修改shadowsocks配置
echo '
{
    "server":["[::0]", "0.0.0.0"],
    "mode":"tcp_and_udp",
    "server_port":5000,
    "local_port":1080,
    "password":"fengkuang",
    "timeout":60,
    "method":"aes-256-gcm"
}
'        >         /etc/shadowsocks-libev/config.json
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
#配置证书自动更新
echo "0 0 1 */2 * service nginx stop; certbot renew; service nginx start;" | crontab
#关闭SELinux
setsebool -P httpd_can_network_connect 1 && setenforce 0
#修改Nginx配置文件
echo '
server{
server_name www.example.com;
set $proxy_name pubmed.ncbi.nlm.nih.gov;
listen 80;
listen [::]:80;
listen 443 ssl;
listen [::]:443 ssl;
ssl_certificate /etc/letsencrypt/live/www.example.com/fullchain.pem;  
ssl_certificate_key /etc/letsencrypt/live/www.example.com/privkey.pem;   
ssl_session_cache shared:SSL:10m;
ssl_session_timeout  10m;
add_header Strict-Transport-Security "max-age=31536000";
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 10s;
charset utf-8;
if ( $scheme = http ){
return 301 https://$server_name$request_uri;
}
if ($http_user_agent ~* (baiduspider|360spider|haosouspider|googlebot|soso|bing|sogou|yahoo|sohu-search|yodao|YoudaoBot|robozilla|msnbot|MJ12bot|NHN|Twiceler)) {
return  403;
}
location /{
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
sendfile on;
tcp_nopush on;
tcp_nodelay on;
keepalive_requests 25600;
keepalive_timeout 300 300;
proxy_buffering off;
proxy_buffer_size 8k;
}
}
'     >      /etc/nginx/conf.d/default.conf
#修改nginx配置文件
sed -i     ''s/www.example.com/$site/g''       /etc/nginx/conf.d/default.conf
#启动V2Ray和Nginx：
systemctl enable v2ray.service
systemctl enable nginx.service
service v2ray restart
service nginx restart
service shadowsocks-libev restart
#验证配置文件，显示监听端口
/usr/bin/v2ray/v2ray -test -config=/etc/v2ray/config.json
nginx -t
netstat -tulpna | grep nginx
#至此V2Ray可正常工作




#BBR加速控制拥堵
#OpenVZ架构安装BBR加速@CentOS7系统：
wget https://github.com/tcp-nanqinlang/lkl-rinetd/releases/download/1.1.0/tcp_nanqinlang-rinetd-centos-multiNIC.sh && bash tcp_nanqinlang-rinetd-centos-multiNIC.sh
#KVM架构安装BBR加速：
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
#升级内核后重启
