# 网站反代主页安装脚本 @ Debian 10
apt     -y    update
apt     -y    full-upgrade
apt     -y    autoremove
apt     -y    install       wget curl zip unzip nginx net-tools
#创建nginx配置文件
echo '
server{
set $proxy_name pubmed.ncbi.nlm.nih.gov;
resolver 8.8.8.8 8.8.4.4 valid=300s;
listen 80;
listen [::]:80;
location /          {
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Referer https://$proxy_name;
proxy_set_header Host $proxy_name;
proxy_pass https://$proxy_name;
proxy_set_header Accept-Encoding "";
}
}
'             >            /etc/nginx/sites-enabled/wordpress.conf
#修改上传文件大小限制
systemctl     enable       nginx
systemctl     restart      nginx
nginx         -vt
netstat       -plnt
#回显nginx、php版本，nginx配置检查和监听端口
#初始化数据库
mysql_secure_installation




setupLNMP () {
apt     -y    install    wget
wget    https://github.com/hanhongju/my_script/raw/master/index.sh    -O    setup.sh
bash    setup.sh

}




