#Trojan安装脚本@Debian 10
#定义网站地址
site=domain 
#关闭防火墙，安装常用软件
apt update
apt install -y   python3-pip wget policycoreutils nginx net-tools curl
#安装Certbot
pip3 install cryptography --upgrade
pip3 install certbot
#申请SSL证书
service nginx stop
certbot certonly   --standalone   --agree-tos   -n    -d    $site    -m   86606682@qq.com 
#安装trojan
bash -c "$(curl -fsSL https://raw.githubusercontent.com/trojan-gfw/trojan-quickstart/master/trojan-quickstart.sh)"
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
#替换trojan配置文件网站地址
sed -i     ''s/www.example.com/$site/g''       /usr/local/etc/trojan/config.json
#赋予trojan监听443端口能力
setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/trojan
#配置证书自动更新
echo "0 0 1 */2 * service trojan stop; certbot renew; service trojan start;" | crontab
#关闭SELinux
setsebool -P httpd_can_network_connect true
#修改nginx配置文件
echo '
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
'                  >            /etc/nginx/conf.d/default.conf

#修改系统控制文件启用BBR
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
#检查目前BBR启动状态
sysctl net.ipv4.tcp_congestion_control
#启动Trojan和Nginx
systemctl enable trojan
systemctl enable nginx
service   trojan   restart
service   nginx    restart
#显示监听端口
netstat -tulpna | grep 'nginx\|trojan'
#至此trojan可正常工作


