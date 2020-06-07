#v2rayclient安装脚本@Debian 10

#下载v2ray，如不能联网，手动下载v2ray至/home目录
wget    -c     https://github.com/v2ray/v2ray-core/releases/download/v4.23.4/v2ray-linux-64.zip     -O     /home/v2ray-linux-64.zip
#解压移动v2ray文件至正确位置，上传配置文件config.json至/home目录
mkdir    /home/v2ray
unzip   -o       /home/v2ray-linux-64.zip       -d          /home/v2ray
mkdir    /usr/bin/v2ray/
mkdir    /etc/v2ray/
mv      -f       /home/v2ray/v2ray                      /usr/bin/v2ray/v2ray
mv      -f       /home/v2ray/v2ctl                      /usr/bin/v2ray/v2ctl
mv      -f       /home/v2ray/geoip.dat                  /usr/bin/v2ray/geoip.dat
mv      -f       /home/v2ray/geosite.dat                /usr/bin/v2ray/geosite.dat
mv      -f       /home/v2ray/config.json                /etc/v2ray/config.json
mv      -f       /home/v2ray/systemd/v2ray.service      /etc/systemd/system/v2ray.service
cp      -f       /home/config.json                      /etc/v2ray/config.json
rm      -rf      /home/v2ray
systemctl daemon-reload
systemctl enable v2ray
service   v2ray   restart
netstat -tulpna | grep 'v2ray'




#设置终端代理
export    ALL_PROXY=socks5://127.0.0.1:8000
#测试外网连接
curl    google.com




#更改dns服务器
echo  '
nameserver 8.8.8.8
nameserver 8.8.4.4
'     >          /etc/resolv.conf


