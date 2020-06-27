




#安装常用软件包：
apt    update
apt    full-upgrade    -y
apt    autoremove      -y
apt    purge           -y         apache2
apt    install         -y         python3-pip wget curl net-tools policycoreutils ntp ntpdate
#下载安装 Caddy
curl https://getcaddy.com | bash -s personal
caddy -version
#允许Caddy绑定到特权端口
setcap 'cap_net_bind_service=+ep' /usr/local/bin/caddy


#为 Caddy 创建目录
mkdir /etc/caddy
mkdir /etc/ssl/caddy
touch /etc/caddy/Caddyfile
mkdir /var/www


#注册服务到Systemd
curl    -s    https://raw.githubusercontent.com/hanhongju/my_script/master/caddy.service       -o    /etc/systemd/system/caddy.service
systemctl    daemon-reload
systemctl    enable     caddy.service
systemctl    restart    caddy.service
#systemctl   stop    caddy.service
systemctl    status     caddy.service






















#curl https://getcaddy.com | bash -s http.cache,http.cors,http.expires,http.filemanager,http.git,http.ipfilter,http.minify,http.nobots,http.ratelimit,http.realip,tls.dns.cloudflare
