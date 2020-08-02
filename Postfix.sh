

site=mail.hongju.fun

apt    update
apt    full-upgrade    -y
apt    autoremove      -y
apt    purge           -y         apache2 nginx
apt    install         -y         python3-pip net-tools postfix postfix-mysql postfix-doc mailutils
#安装Certbot
pip3   install     cryptography --upgrade
pip3   install     certbot
#申请SSL证书
certbot    certonly    --standalone    --agree-tos     -n     -d      $site     -m    86606682@qq.com 
rm       -rf     /home/keys/
mkdir    -p      /home/keys/
cp       /etc/letsencrypt/live/$site/fullchain.pem       /home/keys/fullchain.pem
cp       /etc/letsencrypt/live/$site/privkey.pem         /home/keys/privkey.pem
chmod    -Rf     777       /home/


#配置证书每月1日自动更新
echo       "
0 0 1 * * service trojan stop
1 0 1 * * certbot renew
2 0 1 * * cp   /etc/letsencrypt/live/$site/fullchain.pem    /home/keys/fullchain.pem
2 0 1 * * cp   /etc/letsencrypt/live/$site/privkey.pem      /home/keys/privkey.pem
3 0 1 * * chmod   -Rf   777   /home/
4 0 1 * * service trojan start
"  |  crontab
crontab    -l
service   cron   restart
#修改trojan配置文件


