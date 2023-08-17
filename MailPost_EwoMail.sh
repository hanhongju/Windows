site=hanhongju.com
sed       -i       "s/SELINUX=.*/SELINUX=disabled/g"        /etc/sysconfig/selinux
if        [[   $(free  -m  |  awk   'NR==3{print $2}'   2>&1)    >   3000   ]]
then      echo     "已经有SWAP，无需重复配置"
else      echo     "添加SWAP空间，大小4000M"
          dd       if=/dev/zero of=/mnt/swap bs=1M count=4000
          mkswap   /mnt/swap
          swapon   /mnt/swap
          echo     '/mnt/swap swap swap defaults 0 0'      >>       /etc/fstab
fi
yum         -y         install        git net-tools
cd          /root/
git         clone      https://github.com/gyxuehu/EwoMail.git
sed         -i         "s/yum install epel-release.*/yum install epel-release -y/g"         /root/EwoMail/install/start.sh
cd          /root/EwoMail/install/
bash        start.sh    $site
echo        "127.0.0.1 mail.$site smtp.$site imap.$site"       >>       /etc/hosts
sed         -i          "s/listen.*/listen 80;/g"              /ewomail/nginx/conf/vhost/rainloop.conf
sed         -i          "s/listen.*/listen 8010;/g"            /ewomail/nginx/conf/vhost/ewomail-admin.conf
sed         -i          "/clamd/d"                             /usr/lib/systemd/system/amavisd.service
sed         -i          "/bypass_virus/d"                      /etc/amavisd/amavisd.conf
sed         -i          "/bypass_spam/d"                       /etc/amavisd/amavisd.conf
echo        "
@bypass_virus_checks_maps = (1);
@bypass_spam_checks_maps  = (1);   "                           >>       /etc/amavisd/amavisd.conf
systemctl   daemon-reload
systemctl   stop        clamd@amavisd
systemctl   disable     clamd@amavisd
systemctl   restart     postfix dovecot nginx amavisd
netstat     -plnt
echo        "后台管理端口为8010，账户为admin，密码为ewomail123。"




directsetup () {
sudo    su
yum     -y    install    wget
wget    https://github.com/hanhongju/my_script/raw/master/EwoMail.sh    -O    setup.sh
bash    setup.sh

}




# EwoMail 安装脚本 @ CentOS 7
