#iRedMail邮件服务器搭建@Debian 10
#依赖更新
apt    update
apt    full-upgrade    -y    --fix-missing
apt    autoremove      -y
apt    install         -y      gzip curl net-tools
#更改主机名称
hostname -f
echo  "mx"    >    /etc/hostname
echo  "127.0.0.1       mail.hanhongju.com      mx      localhost      localhost.localdomain"       >        /etc/hosts
hostname -f
#如果没有正确读取本机名称，reboot重启
#下载安装脚本，执行
wget   https://github.com/iredmail/iRedMail/releases/download/1.3.1/iRedMail-1.3.1.tar.gz     -cP      /home/
cd    /home/
tar    zxf    iRedMail-1.3.1.tar.gz
cd     iRedMail-1.3.1
bash   iRedMail.sh


