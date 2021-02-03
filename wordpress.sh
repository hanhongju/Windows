# Wordpress安装脚本 @ Debian 10
site=www.hanhongju.com
#安装常用软件包、LNMP环境：
apt    update
apt    full-upgrade   -y
apt    autoremove     -y
apt    purge          -y      apache2
apt    install        -y      wget curl zip unzip nginx php-fpm php-mysql mariadb-server python3-pip
pip3   install    --upgrade   cryptography certbot
#申请SSL证书
systemctl     stop        nginx apache2
certbot       certonly    --standalone   --agree-tos  -n  -d  $site  -m  86606682@qq.com 
#配置证书每月1日自动更新，每天备份数据库
echo   '
0 0 1 * *     systemctl   stop      nginx
1 0 1 * *     certbot     renew
2 0 * * *     systemctl   restart   nginx
0 1 * * *     apt   full-upgrade   -y
0 2 * * *     apt   autoremove     -y
0 3 * * *     mkdir        -p        /home/dbbackup/
0 4 * * *     mysqldump    -uroot    -pfengkuang     wordpress     >      /home/dbbackup/$(date +\%Y\%m\%d)wordpress.sql
0 5 * * *     mysqldump    -uroot    -pfengkuang     wordpress     >      /home/wordpress.sql
'       |     crontab
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








#安装wordpress网页文件
wget        https://cn.wordpress.org/latest-zh_CN.tar.gz     -cP      /home/
rm         -rf       /home/wordpress/
cd         /home/
tar        -zxf       latest-zh_CN.tar.gz
#网页文件授权，否则会出现无法创建wp配置文件或无法安装主题的问题
chmod      -Rf        777           /home/
chown      -Rf        www-data      /home/
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
mysqldump     -uroot     -pfengkuang     wordpress   >    /home/wordpress.sql
#导入数据库
mysql         -uroot     -pfengkuang     wordpress   <    /home/wordpress.sql



