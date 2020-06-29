#v2rayserver安装脚本@Debian 10
#定义网站地址
echo    "本脚本可以自动安装v2ray，自动申请并使用tls证书加密保护v2ray的流量，反代美国卫生研究所网址进行网站伪装。需要您事先将此VPS的IP地址解析到一个有效域名上。
如果您有多个域名解析到此VPS，请重复运行此脚本并输入不同的域名，那么多个域名地址都可以受到tls的加密保护。如果此VPS使用KVM虚拟技术，此脚本自动开启BBR加速。
安装完成后
端口为             443
用户ID为           15448fce-7c71-11ea-bc55-0242ac130003
额外ID为           0
传输协议为         ws
路径为             /f63lKAx
底层传输安全为     tls
理解并记录下这些信息后请按回车键继续，并在下一栏输入您解析的有效域名。"
read    nothing
echo    "请输入此VPS的IP对应的域名地址："
read    site
echo    "好的，现在要开始安装了。"
sleep   5s



#安装常用软件包：
apt    update
apt    full-upgrade    -y
apt    autoremove      -y
apt    purge           -y         apache2
apt    install         -y         python3-pip wget curl net-tools policycoreutils nginx ntp ntpdate
#安装Certbot和V2Ray
pip3   install     cryptography --upgrade
pip3   install     certbot
bash    -c     "$(curl -L -s https://install.direct/go.sh)"
#配置证书自动更新
echo      "0 0 1 */2 * service nginx stop; certbot renew; service nginx start;"   |   crontab
crontab   -l
#关闭SELinux
setsebool   -P   httpd_can_network_connect   1   &&   setenforce   0
#修改系统控制文件启用BBR
echo     '
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
'         >       /etc/sysctl.conf
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





#申请SSL证书
service     nginx       stop
certbot     certonly    --standalone    --agree-tos     -n     -d      $site     -m    86606682@qq.com 
#创建nginx配置文件
echo '
events {
worker_connections  1024;
}
http {
sendfile    on;
keepalive_timeout  65;
include           /etc/nginx/sites-enabled/*;
}
'         >       /etc/nginx/nginx.conf
echo '
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
'         >       /etc/nginx/sites-enabled/$site.conf
sed      -i       ''s/www.example.com/$site/g''               /etc/nginx/sites-enabled/$site.conf





#启动V2Ray和Nginx：
systemctl   enable    v2ray.service
systemctl   enable    nginx.service
systemctl   restart   v2ray.service
systemctl   restart   nginx.service
#验证配置文件，显示监听端口
netstat  -plunt | grep 'nginx'
/usr/bin/v2ray/v2ray     -test       -config=/etc/v2ray/config.json
#如果nginx配置有错误，重置nginx配置文件
OUTPUT=$(nginx -t 2>&1)
echo   $OUTPUT
if     [[  "$OUTPUT"   =~   "successful"   ]]   ;        
then        echo   "nginx configuration is ok"
            echo   "至此，v2ray可正常工作"
else        echo   "您输入的域名地址可能有问题，所以nginx配置出现了问题，现在所有nginx配置都已被删除。在您确认了域名解析没有问题后再请重新运行本脚本。"
            rm    -rf    /etc/nginx/sites-enabled/*
fi
#至此V2Ray可正常工作




