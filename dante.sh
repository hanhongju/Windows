#socks5代理服务器dante安装脚本@Debian 10
#安装
apt      update
apt      install    -y       dante-server
danted   -v
#编写配置文件
mv        /etc/danted.conf       /etc/danted.conf.bak
echo   '
errorlog:   /var/log/sockd.errlog
logoutput:  /var/log/socks.log
internal: eth0 port = 7000
external: eth0
clientmethod: none
socksmethod: none
user.privileged: root
user.notprivileged: nobody
client pass {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        log: error connect disconnect
}
socks pass {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        log: error connect disconnect
}
'      >         /etc/danted.conf
#启动服务
systemctl      restart       danted
sleep 1s
netstat  -plunt  | grep 'danted'
#回显dante监听端口







#设置tsocks透明代理
apt  install    -y   tsocks
echo '
server       =  127.0.0.1
server_type  =  5
server_port  =  6000
default_user =  none
default_pass =  none
'          >              /etc/tsocks.conf
#在wget之前加上tsocks以使其通过代理





















