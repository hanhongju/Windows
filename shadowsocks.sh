#shadowsocks服务器安装脚本@Debian 10
#安装shadowsocks
apt      update
apt      install     -y    shadowsocks-libev  net-tools
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
apt      install     -y    shadowsocks-libev  net-tools
#写入服务器信息
echo   '
{
  "server": "<serverdomain>",
  "server_port": "3389",
  "local_port": 9000,
  "password": "fengkuang",
  "timeout": 60,
  "method": "aes-256-gcm"
}
'         >        /etc/shadowsocks-libev/root.json
#启动服务
systemctl   enable      shadowsocks-libev-local@root
systemctl   restart     shadowsocks-libev-local@root
sleep 5s
systemctl   status      shadowsocks-libev-local@root
netstat    -tulpna | grep 'ss-local'
#回显ss监听端口





#设置tsocks透明代理
apt  install    -y   tsocks
echo '
server = 127.0.0.1
server_type = 5
server_port = 9000
'          >              /etc/tsocks.conf
#在wget之前加上tsocks以使其通过代理



