#定义服务器地址
echo    "请输入此VPS的IP对应的域名地址："
read    site
#安装trojan
apt  update
apt  install  -y   trojan
systemctl    enable    trojan 

#写入配置文件
echo   '
{
    "run_type": "client",
    "local_addr": "::",
    "local_port": 5000  ,
    "remote_addr": "www.example.com",
    "remote_port": 443,
    "password": [  "fengkuang"  ],
    "log_level": 1,
    "ssl": {
        "verify": true,
        "verify_hostname": true,
        "alpn": [  "h2","http/1.1"  ]
    }
}
'     >     /etc/trojan/config.json
sed      -i       ''s/www.example.com/$site/g''               /etc/trojan/config.json
service  trojan restart
sleep 1s
netstat  -plunt  | grep 'trojan'



#设置tsocks透明代理
apt  install    -y   tsocks
echo '
server       =  127.0.0.1
server_type  =  5
server_port  =  5000
default_user =  none
default_pass =  none
'          >              /etc/tsocks.conf
#测试代理可用性
tsocks      wget     https://cn.wordpress.org/latest-zh_CN.tar.gz      -O     /home/latest-zh_CN.tar.gz




