# Wordpress安装脚本 @ Debian 10 or Ubuntu 20.04
apt    update
apt    full-upgrade   -y
apt    autoremove     -y
apt    install        -y      wget curl zip unzip nginx mariadb-server python3-pip php-fpm php-mysql php-xml
#每天备份数据库
echo    '
0 1 * * *     mkdir         -p          /home/wordpressbackup/
0 2 * * *     mysqldump     -uroot      -pfengkuang     wordpress     >      /home/wordpress/wordpress.sql
0 3 * * *     tar           -Pcf        /home/wordpressbackup/$(date +\%Y\%m\%d)wordpress.tar           /home/wordpress/
0 4 * * *     apt   full-upgrade   -y
0 5 * * *     apt   autoremove     -y
'       |     crontab
systemctl     restart   cron
#创建nginx配置文件
echo '
server {
server_name www.hanhongju.com;
listen 80;
listen [::]:80;
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
#重启服务
systemctl     enable       nginx cron
systemctl     restart      nginx cron
php          -v
nginx        -vt
crontab      -l
ss           -plnt
#回显nginx、php版本，nginx配置检查和监听端口
#初始化数据库
mysql_secure_installation






#还原wordpress文件
tar        -Pxf       /home/wordpress.tar
#修改数据库登录方式
mysql         -uroot     -pfengkuang     -e      "update mysql.user set plugin='mysql_native_password' where User='root'"
#创建新数据库
mysql         -uroot     -pfengkuang     -e      "DROP DATABASE wordpress"
mysql         -uroot     -pfengkuang     -e      "CREATE DATABASE wordpress"
mysql         -uroot     -pfengkuang     -e      "SHOW DATABASEs"
#启动数据库
systemctl     enable       mariadb
systemctl     restart      mariadb
#导入数据库
mysql         -uroot     -pfengkuang     wordpress   <    /home/wordpress/wordpress.sql






#新安装wordpress网页文件
wget       https://cn.wordpress.org/latest-zh_CN.tar.gz     -cP      /home/
rm         -rf        /home/wordpress/
tar        -xf        /home/latest-zh_CN.tar.gz             -C      /home/
#网页文件授权，否则会出现无法创建wp配置文件或无法安装主题的问题
chmod      -Rf        777           /home/
chown      -Rf        www-data      /home/








