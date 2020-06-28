#goproxy使用方法@Debian 10
#服务器架设
#安装程序
apt        update
apt        install     -y        wget tar net-tools
mkdir     /home/goproxy
cd        /home/goproxy
wget   -c   https://github.com/snail007/goproxy/releases/download/v9.8/proxy-linux-amd64.tar.gz
tar        -zxvf        proxy-linux-amd64.tar.gz
#生成tls证书
/home/goproxy/proxy     keygen    -C     proxy
cp     /home/goproxy/proxy.crt         /home/proxy.crt
cp     /home/goproxy/proxy.key         /home/proxy.key
#运行
pkill     proxy
/home/goproxy/proxy         socks   -t   tls   -p   :38080           -C proxy.crt -K proxy.key          --forever --log proxy.log --daemon
sleep 1s
netstat  -plunt | grep 'proxy'
#回显goproxy监听端口




#客户端架设
#定义服务器地址
site=<domain>
#安装程序
apt        update
apt        install     -y        wget tar net-tools
mkdir     /home/goproxy
cd        /home/goproxy
wget   -c   https://github.com/snail007/goproxy/releases/download/v9.8/proxy-linux-amd64.tar.gz
tar        -zxvf        proxy-linux-amd64.tar.gz
#将服务器/home下证书复制到客户端/home目录下，安装证书
cp        /home/proxy.crt      /home/goproxy/proxy.crt
cp        /home/proxy.key      /home/goproxy/proxy.key
#运行
pkill     proxy
/home/goproxy/proxy          socks   -t   tcp   -p    :6000           --always   -T   tls   -P   $site:38080           -C proxy.crt -K proxy.key          --forever --log proxy.log --daemon
sleep 1s
netstat  -plunt | grep 'proxy'
#回显goproxy监听端口





#设置tsocks透明代理
apt  install    -y   tsocks
echo '
server = 127.0.0.1
server_type  =  5
server_port  =  6000
default_user =  none
default_pass =  none
'          >              /etc/tsocks.conf
#在wget之前加上tsocks以使其通过代理



