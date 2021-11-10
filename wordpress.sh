# Wordpress安装脚本 @ Debian 11
apt     -y    update
apt     -y    install       wget curl zip unzip nginx mariadb-server python3-pip php-fpm php-mysql php-xml
#每天备份数据库
echo    '
0 1 * * *     mkdir         -p          /home/wordpressbackup/
0 2 * * *     mysqldump     -uroot      -pfengkuang     wordpress     >      /home/wordpress/wordpress.sql
0 3 * * *     tar           -cf        /home/wordpressbackup/$(date +\%Y\%m\%d)wordpress.tar        -P       /home/wordpress/
0 4 * * *     apt           -y          full-upgrade
0 5 * * *     apt           -y          autoremove
'       |     crontab
systemctl     restart       cron
#创建nginx配置文件
echo '
server {
server_name www.hanhongju.com;
listen 80;
listen [::]:80;
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
sed           -i           ''s/post\_max\_size\ \=.*/post\_max\_size\ \=200M/g''                    /etc/php/7.4/fpm/php.ini
sed           -i           ''s/upload\_max\_filesize\ \=.*/upload\_max\_filesize\ \=200M/g''        /etc/php/7.4/fpm/php.ini
sed           -i           ''s/max\_execution\_time\ \=.*/max\_execution\_time\ \=300/g''           /etc/php/7.4/fpm/php.ini
echo          "client_header_buffer_size 512k;   large_client_header_buffers 4 512k;"       >       /etc/nginx/conf.d/414.conf
systemctl     restart      php7.4-fpm
systemctl     enable       nginx cron
systemctl     restart      nginx cron
php           -v
nginx         -vt
crontab       -l
ss            -plnt   |    awk 'NR>1 {print $4,$6}'   |   column   -t
#回显nginx、php版本，nginx配置检查和监听端口
#初始化数据库
mysql_secure_installation






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






#新安装wordpress网页文件
wget       -c      https://cn.wordpress.org/latest-zh_CN.tar.gz     -P      /home/
rm         -rf     /home/wordpress/
tar        -xf     /home/latest-zh_CN.tar.gz             -C          /home/
#网页文件授权，否则会出现无法创建wp配置文件或无法安装主题的问题
chmod      -Rf     777           /home/
chown      -Rf     www-data      /home/





