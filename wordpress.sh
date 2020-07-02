#wordpress安装脚本@Debian 10
#安装常用软件包、LNMP环境：
apt   update
apt   full-upgrade   -y
apt   autoremove     -y
apt   install        -y        wget curl net-tools policycoreutils nginx php-fpm php-mysql 
#关闭SELinux
setsebool -P httpd_can_network_connect 1 && setenforce 0
#下载wordpress
wget    https://cn.wordpress.org/latest-zh_CN.tar.gz      -P     /home/website/
cd     /home/website   
tar     zxf           latest-zh_CN.tar.gz
chmod   777    -R    /home/website/
#下载探针
wget    https://raw.githubusercontent.com/kmvan/x-prober/master/dist/prober.php     -O     /home/website/wordpress/p.php
#创建nginx配置文件
echo '
server {
listen 80;
listen [::]:80;
root   /home/website/wordpress/;
index   index.php index.html index.htm;
location ~ \.php$ {
fastcgi_pass  unix:/run/php/php7.3-fpm.sock;     #php -v 遇到502 Bad Gateway时查看php版本，确认php-fpm.sock版本
fastcgi_index  index.php;
fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
include        fastcgi_params;
}
}
'    >        /etc/nginx/sites-enabled/wordpress.conf
#重启服务
systemctl     enable       nginx 
systemctl     restart      nginx
#浏览器进入网站开始配置
#设置-固定链接，改为朴素










#安装数据库
apt   install        -y       mariadb-server  
#配置数据库
mysql_secure_installation
#修改数据库登录方式
mysql      -uroot     -pfengkuang     -e      "update mysql.user set plugin='mysql_native_password' where User='root'"
#创建新数据库
mysql      -uroot     -pfengkuang     -e      "DROP DATABASE wordpress"
mysql      -uroot     -pfengkuang     -e      "CREATE DATABASE wordpress"
mysql      -uroot     -pfengkuang     -e      "SHOW DATABASEs"
#开放数据库3306端口给外网
sed      -i       ''s/127.0.0.1/\*/g''         /etc/mysql/mariadb.conf.d/50-server.cnf
#开放数据库用户权限给外网
mysql        -uroot       -pfengkuang     -e      "use mysql; grant all privileges on *.* to 'root'@'%' identified by 'fengkuang' with grant option; flush privileges; select user,host from user;"
systemctl     enable       mariadb
systemctl     restart      mariadb
netstat      -plunt    |   grep   3306
#至此mysql服务开放给公网





#转移网站->备份数据库，存放于db_dump.sql
mysqldump     -uroot     -pfengkuang     wordpress   >    /home/db_dump.sql
#将备份文件导入数据库
mysql         -uroot     -pfengkuang     wordpress   <    /home/db_dump.sql







