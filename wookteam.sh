





yum install -y     gcc gcc-c++ make kernel-devel
yum update  -y     kernel
yum localinstall  -y   http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
#添加安装源
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install -y     nginx php72w php72w-cli php72w-devel php72w-gd php72w-fpm php72w-mbstring php72w-pear php72w-xml php72w-xmlrpc php72w-common php72w-pdo php72w-mysqli

setenforce 0
systemctl enable   nginx php-fpm
systemctl start    nginx php-fpm



\cp       /etc/php-fpm.d/www.conf    /etc/php-fpm.d/www2.conf
sed  -i   '/listen =/d'              /etc/php-fpm.d/www.conf
sed  -i   '/listen.owner =/d'        /etc/php-fpm.d/www.conf
sed  -i   '/listen.group =/d'        /etc/php-fpm.d/www.conf
sed  -i   '/user =/d'                /etc/php-fpm.d/www.conf
sed  -i   '/group =/d'               /etc/php-fpm.d/www.conf
echo   '
listen = /var/run/php-fpm/php-fpm.sock
listen.owner = nginx
listen.group = nginx
user = nginx 
group = nginx
'     >>     /etc/php-fpm.d/www.conf


pecl install swoole     #一路回车




sed  -i    '/extension=/d'         /etc/php.ini
echo    'extension=swoole.so'     >>     /etc/php.ini


cd /home
curl -sS https://getcomposer.org/installer | php 
\mv composer.phar  /usr/local/bin/composer



rpm -ivh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum -y install mysql-community-server
systemctl enable mysqld
systemctl start mysqld


pwd=$(grep     -oP     '(?<=host: ).*'    /var/log/mysqld.log)
echo $pwd



yum install -y supervisor
systemctl enable supervisord
systemctl start supervisord

curl -sL https://rpm.nodesource.com/setup_12.x |  bash -
yum install -y nodejs git






















