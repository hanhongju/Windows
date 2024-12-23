apt     -y    update
#apt    -y    full-upgrade    &&     apt   -y    autoremove
apt     -y    install      wget curl zip unzip nginx certbot net-tools mariadb-server python3-pip redis
apt     -y    install      php-fpm php-mysql php-xml php-curl php-imagick php-mbstring php-zip php-gd php-intl php-redis
certbot       delete       --noninteractive    --cert-name    www.hanhongju.com
certbot       certonly     --noninteractive    --domain       www.hanhongju.com    --standalone    --agree-tos    --email     admin@hanhongju.com\
              --pre-hook   "systemctl stop nginx"   --post-hook   "chmod 777 -R /etc/letsencrypt/; systemctl restart nginx"
echo    '
* * * * *     date          >>          /root/crontest
0 1 * * *     apt           -y          update
0 2 * * *     apt           -y          full-upgrade
0 3 * * *     apt           -y          autoremove
0 4 * * *     mkdir         -p          /root/wordpressbackup/
0 5 * * *     mysqldump     -uroot      -pfengkuang     wordpress     >    /srv/wordpress/wordpress.sql
0 6 * * *     tar           -cf         /root/wordpressbackup/wordpress$(date +\%Y\%m\%d).tar        -P       /srv/wordpress/
0 7 * * *     certbot       renew
'       |     crontab
echo '
server {
server_name www.hanhongju.com;
listen 80;
listen [::]:80;
listen 443 ssl;
listen [::]:443 ssl;
ssl_certificate           /etc/letsencrypt/live/www.hanhongju.com/fullchain.pem;
ssl_certificate_key       /etc/letsencrypt/live/www.hanhongju.com/privkey.pem;
if  ( $scheme = http )    {return 301 https://$server_name$request_uri;}
root      /srv/wordpress/;
index     index.php index.html index.htm;
location ~ \.php$ {
fastcgi_pass   unix:/run/php/php8.2-fpm.sock;     #遇到502 Bad Gateway时使用php -v查看版本，确认php-fpm.sock版本为8.2
fastcgi_index  index.php;
fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
include        fastcgi_params;
client_max_body_size     500M;
}
location / {
if (-f  $request_filename/index.html) {rewrite (.*) $1/index.html break;}
if (-f  $request_filename/index.php)  {rewrite (.*) $1/index.php;}
if (!-f $request_filename)            {rewrite (.*)   /index.php;}
}
rewrite /wp-admin$ $scheme://$host$uri/ permanent;
}
'             >            /etc/nginx/sites-enabled/wordpress.conf
sed           -i           "s/post_max_size =.*/post_max_size =200M/g"                      /etc/php/8.2/fpm/php.ini
sed           -i           "s/upload_max_filesize =.*/upload_max_filesize =200M/g"          /etc/php/8.2/fpm/php.ini
sed           -i           "/max_execution_time/d"              /etc/php/8.2/fpm/php.ini
echo          "max_execution_time = 0"                >>        /etc/php/8.2/fpm/php.ini
echo          "client_header_buffer_size 2048k;   large_client_header_buffers 10 2048k;"     >      /etc/nginx/conf.d/414.conf
systemctl     enable       nginx
systemctl     restart      nginx
nginx         -t
crontab       -l
sysctl        -p
netstat       -plnt
mysql_secure_installation








setupLNMP () {
apt     -y    install    wget
wget    https://raw.githubusercontent.com/hanhongju/my_script/master/wordpress.sh    -O    setup.sh
bash    setup.sh

}




uninstall () {
systemctl    stop      nginx
systemctl    disable   nginx
netstat      -plnt

}




directbackup () {
mysqldump     -uroot      -pfengkuang     wordpress     >        /srv/wordpress/wordpress.sql
tar           -cf         /root/wordpressbackup/wordpress$(date +\%Y\%m\%d).tar       -P      /srv/wordpress/

}




importbackup () {
tar           -Pxf       /srv/wordpress.tar
mysql         -uroot     -pfengkuang     -e      "update mysql.user set plugin='mysql_native_password' where User='root'"
mysql         -uroot     -pfengkuang     -e      "DROP DATABASE wordpress"
mysql         -uroot     -pfengkuang     -e      "CREATE DATABASE wordpress"
mysql         -uroot     -pfengkuang     -e      "SHOW DATABASEs"
systemctl     enable     mariadb
systemctl     restart    mariadb
mysql         -uroot     -pfengkuang     wordpress   <    /srv/wordpress/wordpress.sql

}




installanewsite () {
wget       -c      https://cn.wordpress.org/latest-zh_CN.tar.gz
rm         -rf     /srv/wordpress/
tar        -xf     latest-zh_CN.tar.gz       -C     /srv/
#phpMyAdmin
wget       -c      https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.zip
unzip      phpMyAdmin-5.2.1-all-languages.zip
rm         -rf     /srv/wordpress/phpmyadmin/
mv         phpMyAdmin-5.2.1-all-languages           /srv/wordpress/phpmyadmin/
#网页文件授权，否则会出现无法创建wp配置文件或无法安装主题的问题
chmod      -Rf     777           /srv/wordpress/
chown      -Rf     www-data      /srv/wordpress/
chmod      -Rf     755           /srv/wordpress/wp-content/

}




# Wordpress安装脚本 @ Debian 11
#cron任务须由crontab安装，直接修改配置文件无效
#wget的-O参数和-cP参数只能二选一
