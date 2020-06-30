#trojan安装脚本@Debian 10
#定义网站地址
echo    "本脚本可以自动安装trojan，自动申请并使用tls证书加密保护trojan的流量，反代美国国家生物技术信息中心网址进行网站伪装。需要您事先将此VPS的IP地址解析到一个有效域名上。
如果此VPS使用KVM虚拟技术，此脚本自动开启BBR加速。
理解这些信息后请按回车键继续，并在下一栏输入您解析的有效域名。如果域名输入有误请按Ctrl+C终止脚本运行，然后重新运行脚本。"
read    nothing
echo    "请输入此VPS的IP对应的域名地址："
read    site
echo    "好的，现在要开始安装了。"
sleep   5s



begin_time=$(date +%s)
#安装常用软件包：
apt    update
apt    full-upgrade    -y
apt    autoremove      -y
apt    purge           -y         apache2
apt    install         -y         python3-pip wget curl net-tools policycoreutils nginx ntp ntpdate
#安装Certbot
pip3   install     cryptography --upgrade
pip3   install     certbot
#配置证书自动更新
echo          "0 0 1 */2 * service trojan stop; certbot renew; service trojan start;"          |        crontab
crontab   -l
#关闭SELinux
setsebool -P httpd_can_network_connect true
#修改系统控制文件启用BBR
echo     '
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
'         >       /etc/sysctl.conf
sysctl   -p
#修改nginx配置文件
echo '
events {
worker_connections  1024;
}
http {
sendfile    on;
keepalive_timeout  65;
server {
listen 127.0.0.1:80;
location / {
proxy_pass https://pubmed.ncbi.nlm.nih.gov;
}
}
server {
listen 0.0.0.0:80;
listen [::]:80;
location / {
return 301 https://$host$request_uri;
}
}
}
'         >       /etc/nginx/nginx.conf












#申请SSL证书
service     nginx       stop
certbot     certonly    --standalone    --agree-tos     -n     -d      $site     -m    86606682@qq.com 
#安装trojan
rm           -rf        /usr/local/etc/trojan/config.json               /etc/systemd/system/trojan.service
bash         -c         "$(curl -fsSL https://raw.githubusercontent.com/trojan-gfw/trojan-quickstart/master/trojan-quickstart.sh)"
#赋予trojan监听443端口能力
setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/trojan
#修改trojan配置文件
echo '
{
    "run_type": "server",
    "local_addr": "::",
    "local_port": 443,
    "remote_addr": "127.0.0.1",
    "remote_port": 80,
    "password": [
        "fengkuang",
        "password2"
    ],
    "log_level": 1,
    "ssl": {
        "cert": "/etc/letsencrypt/live/www.example.com/fullchain.pem",
        "key": "/etc/letsencrypt/live/www.example.com/privkey.pem",
        "key_password": "",
        "cipher": "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384",
        "cipher_tls13": "TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384",
        "prefer_server_cipher": true,
        "alpn": [
            "http/1.1"
        ],
        "alpn_port_override": {
            "h2": 81
        },
        "reuse_session": true,
        "session_ticket": false,
        "session_timeout": 600,
        "plain_http_response": "",
        "curves": "",
        "dhparam": ""
    },
    "tcp": {
        "prefer_ipv4": false,
        "no_delay": true,
        "keep_alive": true,
        "reuse_port": false,
        "fast_open": false,
        "fast_open_qlen": 20
    },
    "mysql": {
        "enabled": false,
        "server_addr": "127.0.0.1",
        "server_port": 3306,
        "database": "trojan",
        "username": "trojan",
        "password": "",
        "cafile": ""
    }
}
'                 >                /usr/local/etc/trojan/config.json
sed -i     ''s/www.example.com/$site/g''       /usr/local/etc/trojan/config.json
#启动trojan和Nginx
systemctl    enable    trojan
systemctl    enable    nginx
service      trojan    restart
service      nginx     restart
#显示监听端口
netstat -tulpna | grep 'nginx\|trojan'
OUTPUT=$(netstat -tulpna | grep 'nginx\|trojan'    2>&1)
nginx -t
if     [[  "$OUTPUT"   =~   "trojan"   ]]   ;        
then        echo   "至此，trojan可正常工作。"
else        echo   "您输入的域名地址可能没有正确解析或者短时间申请了太多的证书，不能正常申请证书，所以trojan不能正常工作。在您确认了域名解析没有问题后再请重新运行本脚本。"
fi
finish_time=$(date +%s)
time_consume=$((   finish_time   -   begin_time ))
echo   "脚本运行时间$time_consume秒。"
#至此trojan可正常工作


