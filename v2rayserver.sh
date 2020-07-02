#v2rayserver安装脚本@Debian 10
#定义网站地址
echo    "
本脚本可以自动安装v2ray，自动申请并使用tls证书加密保护v2ray的流量，反代美国国家生物技术信息中心网址进行网站伪装。需要您事先将此VPS的IP地址解析到一个有效域名上。
如果您有多个域名解析到此VPS，请重复运行此脚本并输入不同的域名，那么多个域名地址都可以受到tls的加密保护。如果此VPS使用KVM虚拟技术，此脚本自动开启BBR加速。
同时，此脚本还添加了ss服务，端口为10086，密码为fengkuang，加密方法为aes-256-gcm。
安装完成后v2ray配置:
端口为             443
用户ID为           15448fce-7c71-11ea-bc55-0242ac130003
额外ID为           0
传输协议为         ws
路径为             /f63lKAx
底层传输安全为     tls
理解并记录下这些信息后请按回车键继续，并在下一栏输入您解析的有效域名。如果域名输入有误请按Ctrl+C终止脚本运行，然后重新运行脚本。
This script can automatically setup v2ray， register a tls certification and protect your v2ray stream. Nginx installed can reverse proxy united states national biotechnology information center website to mask your website. This script requires you have a domain which had been resolved to IP of this VPS.
If you have several domains resolved to this VPS， you could repeat running this script and type in different domains which could all be protected by tls. If your VPS is based on a KVM virtualization technology， this script can automatically enable BBR acceleration.
Meanwhile，this script also add a shadowsocks server whose port is 10086，password is fengkuang and encryption method is aes-256-gcm.
After your running this script， your v2ray configuration:
port is                              443
user ID is                           15448fce-7c71-11ea-bc55-0242ac130003
transport protocol is                ws
path is                              /f63lKAx
milestone transport security is      tls.
Understand and record this information， then press enter to proceed. Type in your available domain. If you type in a wrong code， you can press Ctrl + C to cancel script running， after which， you can run script again to restart setup.
"
read    nothing
echo    "
请输入此VPS的IP对应的域名地址：
Now type in your VPS's domain:
"
read    site
echo    "
好的，现在要开始安装了。
OK， it is about to start.
"
sleep   5s





#计时
begin_time=$(date +%s)
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
    "log": {
        "access": "/var/log/v2ray/access.log",
        "error": "/var/log/v2ray/error.log",
        "loglevel": "warning"
    },
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
    "outbound": {
        "protocol": "freedom",
        "settings": {}
    },
    "inboundDetour": [
        {
            "protocol": "shadowsocks",
            "port": 10086,
            "settings": {
                "method": "aes-256-gcm",
                "password": "fengkuang",
                "udp": true,
                "level": 1
            }
        }
    ],
    "outboundDetour": [
        {
            "protocol": "blackhole",
            "settings": {},
            "tag": "blocked"
        }
    ],
    "routing": {
        "strategy": "rules",
        "settings": {
            "rules": [
                {
                    "type": "field",
                    "ip": [
                        "0.0.0.0/8",
                        "10.0.0.0/8",
                        "100.64.0.0/10",
                        "127.0.0.0/8",
                        "169.254.0.0/16",
                        "172.16.0.0/12",
                        "192.0.0.0/24",
                        "192.0.2.0/24",
                        "192.168.0.0/16",
                        "198.18.0.0/15",
                        "198.51.100.0/24",
                        "203.0.113.0/24",
                        "::1/128",
                        "fc00::/7",
                        "fe80::/10"
                    ],
                    "outboundTag": "blocked"
                }
            ]
        }
    }
}
' > /etc/v2ray/config.json

















#申请SSL证书
service     nginx       stop
certbot     certonly    --standalone    --agree-tos     -n     -d      $site     -m    86606682@qq.com 
#创建nginx配置文件
mkdir      -p      /etc/nginx/sites-enabled/
echo '
events {}
http   {include    /etc/nginx/sites-enabled/*;}
'        >         /etc/nginx/nginx.conf
echo '
server{
server_name www.example.com;
set $proxy_name pubmed.ncbi.nlm.nih.gov;
listen 80;
listen [::]:80;
resolver 8.8.8.8 8.8.4.4 valid=300s;
listen 443 ssl;
listen [::]:443 ssl;
ssl_certificate          /etc/letsencrypt/live/www.example.com/fullchain.pem;  
ssl_certificate_key      /etc/letsencrypt/live/www.example.com/privkey.pem;   
if ( $scheme = http ){return 301 https://$server_name$request_uri;}
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
then        echo   "
至此，v2ray可正常工作。
Now， your v2ray can work properly.
"
else        echo   "
您输入的域名地址可能没有正确解析或者短时间申请了太多的证书，不能正常申请证书，所以nginx不能正常工作。现在所有nginx配置都已被删除。在您确认了域名解析没有问题后再请重新运行本脚本。
The domain you gave cannot be properly resolved or had registered too many certifications， so that script cannot registered properly and nginx cannot work properly. Now all nginx configurations had been deleted. Please re-run this script after confirmation of availability of your domain.
"
            rm    -rf    /etc/nginx/sites-enabled/*
fi
finish_time=$(date +%s)
time_consume=$((   finish_time   -   begin_time ))
echo   "
脚本运行时间$time_consume秒。
Time consumed is $time_consume seconds.
"
#至此V2Ray可正常工作



