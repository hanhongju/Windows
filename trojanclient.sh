# trojan客户端安装脚本 @ Debian 10 or Ubuntu 20
site=cloud2.thenote.site
apt           -y   update    
apt           -y   install  trojan
echo '
{"run_type": "client"
,"local_addr": "127.0.0.1"
,"local_port": 1080
,"remote_addr": "www.example.com"
,"remote_port": 443
,"password": ["feichengwurao"]
,"ssl": {"sni": "www.example.com"
        ,"alpn": ["http/1.1"]
        }
}
'                     >                                   /etc/trojan/config.json
sed         -i        ''s/www.example.com/$site/g''       /etc/trojan/config.json
systemctl   enable    trojan
systemctl   restart   trojan
trojan      -t
ss          -plnt   |   awk 'NR>1 {print $4,$6}'   |   column   -t



