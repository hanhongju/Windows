

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





