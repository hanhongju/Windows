#wordpress安装脚本@Debian 10
#定义网站URL
site=hanhongju.com
#安装常用软件包、LNMP环境：
apt   update
apt   full-upgrade   -y
apt   autoremove     -y
apt   install        -y      python3-pip  wget curl  net-tools    policycoreutils     mariadb-server      nginx      php-fpm      php-mysql 
#安装Certbot
pip3 install cryptography --upgrade
pip3 install certbot
#申请SSL证书
service     nginx    stop
certbot     certonly    --standalone    --agree-tos   -n     -d    $site     -m    86606682@qq.com 
rm   -f     /etc/letsencrypt/live/fullchain.pem              /etc/letsencrypt/live/privkey.pem
ln   -s     /etc/letsencrypt/live/$site/fullchain.pem        /etc/letsencrypt/live/fullchain.pem
ln   -s     /etc/letsencrypt/live/$site/privkey.pem          /etc/letsencrypt/live/privkey.pem
#配置证书自动更新
echo "0 0 1 */2 * service nginx stop; certbot renew; service nginx start;" | crontab
#关闭SELinux
setsebool -P httpd_can_network_connect 1 && setenforce 0
#下载wordpress至网站根目录
# wget命令参数   -O不会创建目录    -P可以创建深层次目录
wget  -c   https://cn.wordpress.org/latest-zh_CN.tar.gz      -P     /home/website/
chmod   777   -R   /home/website/
#解压缩wordpress安装包`
cd   /home/website   
tar zxf  latest-zh_CN.tar.gz
#拷贝wordpress程序至网站根目录
mv     wordpress/*  .                                                     
#删除wp压缩包
rm    -rf     wordpress     latest-zh_CN.tar.gz
#下载探针
wget   -c   https://raw.githubusercontent.com/kmvan/x-prober/master/dist/prober.php     -O     /home/website/p.php
#创建nginx配置文件
echo '
server {
server_name www.example.com;
listen 80;
listen [::]:80;
listen 443 ssl;
listen [::]:443 ssl;
ssl_certificate       /etc/letsencrypt/live/www.example.com/fullchain.pem;  
ssl_certificate_key   /etc/letsencrypt/live/www.example.com/privkey.pem;   
if ( $scheme = http ){
return 301 https://$server_name$request_uri;
}
root   /home/website/;
index   index.php index.html index.htm;
location ~ \.php$ {
fastcgi_pass  unix:/run/php/php7.3-fpm.sock;     #php -v 遇到502 Bad Gateway时查看php版本，确认php-fpm.sock版本
fastcgi_index  index.php;
fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
include        fastcgi_params;
}
}
'    >        /etc/nginx/sites-enabled/default.conf
#修改nginx配置文件
sed   -i     ''s/www.example.com/$site/g''        /etc/nginx/sites-enabled/default.conf
service   nginx   restart
#配置数据库
mysql_secure_installation
#修改数据库登录方式
mysql      -uroot    -pfengkuang     -e      "update mysql.user set plugin='mysql_native_password' where User='root'"
#创建新数据库
mysql      -uroot    -pfengkuang     -e      "DROP DATABASE wordpress"
mysql      -uroot    -pfengkuang     -e      "CREATE DATABASE wordpress"
#重启服务
systemctl   enable   nginx 
systemctl   enable   mariadb
service     nginx    restart
service     mariadb  restart
#浏览器进入网站开始配置
#设置-固定链接，改为朴素




#转移网站->备份数据库，存放于wordpress.sql
mysqldump  -uroot    -pfengkuang     wordpress   >    /home/db_dump.sql
#将备份文件导入数据库
mysql      -uroot    -pfengkuang     wordpress   <    /home/db_dump.sql





#开放数据库给外网连接
#开放3306端口给外网
sed      -i       ''s/127.0.0.1/\*/g''         /etc/mysql/mariadb.conf.d/50-server.cnf
service     mariadb  restart
netstat    -an | grep 3306
#添加外网连接数据库权限
mysql      -uroot    -pfengkuang     -e      "use mysql; grant all privileges on *.* to 'root'@'%' identified by 'fengkuang' with grant option; flush privileges; select user,host from user;"
#至此mysql服务开放给公网

