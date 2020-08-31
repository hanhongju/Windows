#wordpress安装脚本@Debian 10
#安装常用软件包、LNMP环境：
apt   update
apt   full-upgrade   -y
apt   autoremove     -y
apt   install        -y      wget curl zip unzip net-tools nginx php-fpm php-mysql mariadb-server
#安装wordpress网页文件
wget        https://cn.wordpress.org/latest-zh_CN.tar.gz     -cP      /home/
rm         -rf       /home/wordpress/
cd         /home/
tar        -zxf       latest-zh_CN.tar.gz
chmod      -Rf        777           /home/
chown      -Rf        www-data      /home/
#创建nginx配置文件
echo '
server {
server_name   hanhongju.com;
listen 80;
listen [::]:80;
root     /home/wordpress/;
index     index.php index.html index.htm;
location ~ \.php$ {
fastcgi_pass   unix:/run/php/php7.3-fpm.sock;     #php -v 遇到502 Bad Gateway时查看php版本，确认php-fpm.sock版本
fastcgi_index  index.php;
fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
include        fastcgi_params;
}
}
'         >         /etc/nginx/sites-enabled/hanhongju.com
#重启服务
systemctl     enable       nginx 
systemctl     restart      nginx
php          -v
nginx        -vt
netstat      -plnt
#回显nginx、php版本，nginx配置检查和监听端口












#初始化数据库
mysql_secure_installation
#修改数据库登录方式
mysql         -uroot     -pfengkuang     -e      "update mysql.user set plugin='mysql_native_password' where User='root'"
#创建新数据库
mysql         -uroot     -pfengkuang     -e      "DROP DATABASE wordpress"
mysql         -uroot     -pfengkuang     -e      "CREATE DATABASE wordpress"
mysql         -uroot     -pfengkuang     -e      "SHOW DATABASEs"
#开放数据库给外网
<<BLOCK
sed      -i       ''s/127.0.0.1/\*/g''         /etc/mysql/mariadb.conf.d/50-server.cnf
mysql         -uroot     -pfengkuang     -e      "use mysql; grant all privileges on *.* to 'root'@'%' identified by 'fengkuang' with grant option; flush privileges; select user,host from user;"
BLOCK
#每天0时自动备份数据库
mkdir    -p     /home/dbbackup/
echo  '
0 0 * * *     mysqldump    -uroot    -pfengkuang     wordpress     >      /home/dbbackup/$(date "+\%Y\%m\%d")wordpress.sql
'     >     /home/crontab
crontab     /home/crontab
crontab     -l
service   cron   restart
#启动数据库
systemctl     enable       mariadb
systemctl     restart      mariadb
netstat      -plnt
#回显mysql和nginx监听端口













#数据库备份
#备份数据库，存放于/home/
mysqldump     -uroot     -pfengkuang     wordpress   >    /home/wordpress.sql
#导入数据库
mysql         -uroot     -pfengkuang     wordpress   <    /home/wordpress.sql



#网站文件wordpress.zip备份到/home文件夹
cd        /home/
zip       -q        wordpress.zip           -r      ./wordpress/
#创建nginx配置文件，准备远程下载
echo '
server {
server_name   bak.hanhongju.com;
listen 80;
listen [::]:80;
root     /home/;
}
'         >         /etc/nginx/sites-enabled/bak.hanhongju.com
systemctl     restart      nginx



#远程下载wordpress.zip
wget       http://bak.hanhongju.com/wordpress.zip      -O     /home/wordpress.zip
#或上传wordpress.zip到/home文件夹，还原wordpress文件
rm        -rf      /home/wordpress/
unzip     -qo      /home/wordpress.zip      -d       /home/










