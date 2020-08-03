#iRedMail邮件服务器搭建@Debian 10
#依赖更新
apt    update
apt    full-upgrade    -y    --fix-missing
apt    autoremove      -y
apt    install         -y      gzip curl
#更改rDNS
hostname -f
echo  "hj"    >    /etc/hostname
dynamic_ip=`curl ip.sb`
echo  $dynamic_ip
sed      -i       "/$dynamic_ip/d"           /etc/hosts
echo  "$dynamic_ip     mail.hanhongju.com      hj"       >>        /etc/hosts
hostname -f
#下载安装脚本，执行
wget  https://github.com/iredmail/iRedMail/releases/download/1.3.1/iRedMail-1.3.1.tar.gz    -cP     /home/
cd    /home/
tar zxf iRedMail-1.3.1.tar.gz
cd     iRedMail-1.3.1
bash   iRedMail.sh



