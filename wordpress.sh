# Wordpress安装脚本 @ Debian 10 or Ubuntu 20.04
site=www.hanhongju.com
#安装软件申请证书
apt    update
apt    full-upgrade   -y
apt    autoremove     -y
apt    purge          -y      apache2
apt    install        -y      wget curl zip unzip nginx certbot mariadb-server python3-pip php-fpm php-mysql php-xml
systemctl     stop        nginx apache2
certbot       certonly    --standalone -n --agree-tos -m 86606682@qq.com -d $site
chmod         -R   777    /etc/letsencrypt/
#配置证书每月1日自动更新，每天备份数据库
echo    '
0 0 1 * *     systemctl     stop        nginx apache2
1 0 1 * *     certbot       renew
2 0 1 * *     chmod         -R   777    /etc/letsencrypt/
3 0 * * *     systemctl     restart     nginx
0 1 * * *     mkdir         -p          /home/dbbackup/
0 2 * * *     mysqldump     -uroot      -pfengkuang     wordpress     >      /home/dbbackup/$(date +\%Y\%m\%d)wordpress.sql
0 3 * * *     mysqldump     -uroot      -pfengkuang     wordpress     >      /home/wordpress/wordpress.sql
0 4 * * *     apt   full-upgrade   -y
0 5 * * *     apt   autoremove     -y
'       |     crontab
systemctl     restart   cron
#创建nginx配置文件
echo '
server {
server_name www.example.com;
listen 80;
listen [::]:80;
listen 443 ssl;
listen [::]:443 ssl;
ssl_certificate          /etc/letsencrypt/live/www.example.com/fullchain.pem;  
ssl_certificate_key      /etc/letsencrypt/live/www.example.com/privkey.pem;   
if ( $scheme = http ){return 301 https://$server_name$request_uri;}
root      /home/wordpress/;
index     index.php index.html index.htm;
location ~ \.php$ {
fastcgi_pass   unix:/run/php/php7.3-fpm.sock;     #php -v 遇到502 Bad Gateway时查看php版本，确认php-fpm.sock版本
fastcgi_index  index.php;
fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
include        fastcgi_params;
}
}
'         >         /etc/nginx/sites-enabled/wordpress.conf
sed      -i        ''s/www.example.com/$site/g''             /etc/nginx/sites-enabled/wordpress.conf
#重启服务
systemctl     enable       nginx cron
systemctl     restart      nginx cron
php          -v
nginx        -vt
crontab      -l
ss           -plnt
#回显nginx、php版本，nginx配置检查和监听端口










#新安装wordpress网页文件
wget       https://cn.wordpress.org/latest-zh_CN.tar.gz     -cP      /home/
rm         -rf        /home/wordpress/
tar        -xf        /home/latest-zh_CN.tar.gz             -C      /home/
#网页文件授权，否则会出现无法创建wp配置文件或无法安装主题的问题
chmod      -Rf        777           /home/
chown      -Rf        www-data      /home/
#打包wordpress文件
tar        -Pcf       /home/wordpress.tar       /home/wordpress/
#还原wordpress文件
tar        -Pxf       /home/wordpress.tar











#初始化数据库
mysql_secure_installation
#修改数据库登录方式
mysql         -uroot     -pfengkuang     -e      "update mysql.user set plugin='mysql_native_password' where User='root'"
#创建新数据库
mysql         -uroot     -pfengkuang     -e      "DROP DATABASE wordpress"
mysql         -uroot     -pfengkuang     -e      "CREATE DATABASE wordpress"
mysql         -uroot     -pfengkuang     -e      "SHOW DATABASEs"
#启动数据库
systemctl     enable       mariadb
systemctl     restart      mariadb
#数据库备份
#备份数据库，存放于/home/
mysqldump     -uroot     -pfengkuang     wordpress   >    /home/wordpress/wordpress.sql
#导入数据库
mysql         -uroot     -pfengkuang     wordpress   <    /home/wordpress/wordpress.sql









