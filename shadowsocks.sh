#shadowsocks安装脚本@Debian 10
#安装shadowsocks
apt  update
apt  install  -y    shadowsocks-libev
#创建shadowsocks配置文件
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
netstat -tulpna | grep 'ss-server'
#至此shadowsocks可正常工作
