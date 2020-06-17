#v2rayclient安装脚本@Debian 10

#下载v2ray，如不能联网，手动下载v2ray.zip至/home目录或/home/hj目录，上传配置文件config.json至/home目录或/home/hj目录
wget    -c     https://github.com/v2ray/v2ray-core/releases/download/v4.23.4/v2ray-linux-64.zip     -O     /home/v2ray-linux-64.zip
#安装v2ray文件
apt   update
apt   install    -y      unzip  zip  curl   wget
mkdir    /home/v2ray
mkdir    /usr/bin/v2ray/
mkdir    /etc/v2ray/
cp      -f       /home/hj/v2ray-linux-64.zip            /home/v2ray-linux-64.zip
unzip   -o       /home/v2ray-linux-64.zip       -d      /home/v2ray
mv      -f       /home/v2ray/v2ray                      /usr/bin/v2ray/v2ray
mv      -f       /home/v2ray/v2ctl                      /usr/bin/v2ray/v2ctl
mv      -f       /home/v2ray/geoip.dat                  /usr/bin/v2ray/geoip.dat
mv      -f       /home/v2ray/geosite.dat                /usr/bin/v2ray/geosite.dat
#配置v2ray服务
mv      -f       /home/v2ray/systemd/v2ray.service      /etc/systemd/system/v2ray.service
systemctl   daemon-reload
systemctl   enable      v2ray
#导入节点信息文件
cp      -f       /home/hj/config.json                   /home/config.json
cp      -f       /home/config.json                      /etc/v2ray/config.json
#读取节点信息，重启
service    v2ray     restart     
sleep 1s
netstat -tulpna | grep 'v2ray'
#回显v2ray监听端口


#curl代理下载
curl    -x   socks5://127.0.0.1:8000    -O    -C -    <URL>



#更改dns服务器
echo  '
nameserver 8.8.8.8
nameserver 8.8.4.4
'     >          /etc/resolv.conf


