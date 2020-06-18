#shadowsocks服务器安装脚本@Debian 10
#安装shadowsocks
apt  update
apt  install  -y    shadowsocks-libev
#创建shadowsocks-server配置文件
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
#重启服务
service shadowsocks-libev restart
sleep 1s
netstat -tulpna | grep 'ss-server'
#至此shadowsocks可正常工作


#shadowsocks客户端使用脚本@Debian 10
#安装shadowsocks
apt      update
apt      install     -y    shadowsocks-libev screen net-tools
#screen中启动ss客户端
screen     -R   ss
ss-local   -p   3389   -l  1080   -k   fengkuang  -t   60   -m   aes-256-gcm   -s  <serverdomain>
#关闭shell，启动软件，设置代理


#关闭shadowsocks客户端
netstat -tulpna | grep 'ss-local'
screen         -ls
pkill    screen    


