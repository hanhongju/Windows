# Wordpress安装脚本 @ Debian 11
site=www.hanhongju.com
apt   -y    update
apt   -y    full-upgrade
apt   -y    autoremove
apt   -y    install   wget curl zip unzip nginx mariadb-server python3-pip php-fpm php-mysql php-xml certbot net-tools certbot
certbot     certonly  --standalone  -n  --agree-tos  -m  86606682@qq.com  -d  $site\
            --pre-hook  "systemctl stop nginx"  --post-hook  "systemctl restart nginx"
#每天备份数据库，cron任务须由crontab安装，直接修改配置文件无效
echo    '
* * * * *     date          >>          /home/crontest
0 1 * * *     apt           -y          update
0 2 * * *     apt           -y          full-upgrade
0 3 * * *     apt           -y          autoremove
0 4 * * *     mkdir         -p          /home/wordpressbackup/
0 5 * * *     mysqldump     -uroot      -pfengkuang     wordpress     >    /home/wordpress/wordpress.sql
0 6 * * *     tar           -cf         /home/wordpressbackup/wordpress$(date +\%Y\%m\%d\-\%H\%M\%S).tar        -P       /home/wordpress/
0 0 1 * *     certbot       renew       --pre-hook "systemctl stop nginx"      --post-hook "systemctl restart nginx trojan"
'       |     crontab
#创建nginx配置文件
echo '
server {
server_name www.hanhongju.com;
listen 80;
listen [::]:80;
listen 443 ssl;
listen [::]:443 ssl;
ssl_certificate           /etc/letsencrypt/live/www.hanhongju.com/fullchain.pem;
ssl_certificate_key       /etc/letsencrypt/live/www.hanhongju.com/privkey.pem;
if  ( $scheme = http )   {return 301 https://$host$request_uri;}
root      /home/wordpress/;
index     index.php index.html index.htm;
location ~ \.php$ {
fastcgi_pass   unix:/run/php/php7.4-fpm.sock;     #php -v 遇到502 Bad Gateway时查看php版本，确认php-fpm.sock版本
fastcgi_index  index.php;
fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
include        fastcgi_params;
}
}
'             >            /etc/nginx/sites-enabled/wordpress.conf
#修改上传文件大小限制
sed           -i           "s/post_max_size =.*/post_max_size =200M/g"                      /etc/php/7.4/fpm/php.ini
sed           -i           "s/upload_max_filesize =.*/upload_max_filesize =200M/g"          /etc/php/7.4/fpm/php.ini
sed           -i           "/max_execution_time/d"              /etc/php/7.4/fpm/php.ini
echo          "max_execution_time = 0"                >>        /etc/php/7.4/fpm/php.ini
echo          "client_header_buffer_size 2048k;   large_client_header_buffers 10 2048k;"     >      /etc/nginx/conf.d/414.conf
systemctl     enable       nginx
systemctl     restart      nginx php7.4-fpm
php           -v
nginx         -t
crontab       -l
netstat       -plnt
#初始化数据库
mysql_secure_installation




setupLNMP () {
apt     -y    install    wget
wget    https://github.com/hanhongju/my_script/raw/master/wordpress.sh    -O    setup.sh
bash    setup.sh

}




uninstall () {
systemctl    stop      nginx
systemctl    disable   nginx
netstat      -plnt

}




directbackup () {
mysqldump     -uroot      -pfengkuang     wordpress     >        /home/wordpress/wordpress.sql
tar           -cf         /home/wordpress.tar           -P       /home/wordpress/

}




importbackup () {
#还原wordpress文件
tar           -Pxf       /home/wordpress.tar
#修改数据库登录方式
mysql         -uroot     -pfengkuang     -e      "update mysql.user set plugin='mysql_native_password' where User='root'"
#创建新数据库
mysql         -uroot     -pfengkuang     -e      "DROP DATABASE wordpress"
mysql         -uroot     -pfengkuang     -e      "CREATE DATABASE wordpress"
mysql         -uroot     -pfengkuang     -e      "SHOW DATABASEs"
#启动数据库
systemctl     enable     mariadb
systemctl     restart    mariadb
#导入数据库
mysql         -uroot     -pfengkuang     wordpress   <    /home/wordpress/wordpress.sql

}




installanewsite () {
#新安装wordpress网页文件；wget的-O参数和-cP参数只能二选一
wget       -c      https://cn.wordpress.org/latest-zh_CN.tar.gz
rm         -rf     /home/wordpress/
tar        -xf     latest-zh_CN.tar.gz     -C     /home/
#网页文件授权，否则会出现无法创建wp配置文件或无法安装主题的问题
chmod      -Rf     777           /home/wordpress/
chown      -Rf     www-data      /home/wordpress/

}





