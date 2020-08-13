#syncthing安装脚本@Debian 10
apt   update
apt   full-upgrade   -y
apt   autoremove     -y
apt   install        -y    tar wget unzip zip net-tools nginx
#安装网页文件
wget      https://github.com/syncthing/syncthing/releases/download/v1.7.1/syncthing-linux-amd64-v1.7.1.tar.gz     -cP     /home/
cd       /home/
tar      -zxf        syncthing-linux-amd64-v1.7.1.tar.gz
cd        syncthing-linux-amd64-v1.7.1
cp        syncthing                                           /usr/bin/syncthing
cp        etc/linux-systemd/system/syncthing@.service         /etc/systemd/system/syncthing@.service
rm       -rf        /home/syncthing-linux-amd64-v1.7.1/       /home/syncthing-linux-amd64-v1.7.1.tar.gz
#生成配置文件，配置系统服务
deluser      sync
adduser      sync    --system    --group
systemctl    enable    syncthing@sync.service
systemctl    start     syncthing@sync.service
sleep 5s
systemctl    stop      syncthing@sync.service
#修改配置文件，启动服务
sed         -i        's/127.0.0.1/0.0.0.0/g'          /home/sync/.config/syncthing/config.xml
systemctl    restart   syncthing@sync.service
#配置nginx反代
echo  '
server {
server_name   sync.hanhongju.com;
listen 80;
listen [::]:80;
location /      {
proxy_pass                 http://127.0.0.1:8384/;
proxy_http_version         1.1;
proxy_set_header           X-Forwarded-Host        $http_host;
http2_push_preload on;     #NGINX从1.13.9版本开始支持HTTP/2服务端推送
}
}
'            >               /etc/nginx/sites-enabled/sync.hanhongju.com
service  nginx  restart
sleep 1s
netstat  -plunt | grep 'syncthing\|nginx'
#回显监听端口



