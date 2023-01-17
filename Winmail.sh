# WinMail 安装脚本 @ CentOS 7.5-7.9
#添加SWAP缓存空间
if        [[   $(free  -m  |  awk   'NR==3{print $2}'   2>&1)    >   3000   ]]
then      echo     "已经有SWAP，无需重复配置"
else      echo     "添加SWAP空间，大小4000M"
          dd       if=/dev/zero of=/mnt/swap bs=1M count=4000
          mkswap   /mnt/swap
          swapon   /mnt/swap
          echo     '/mnt/swap swap swap defaults 0 0'      >>       /etc/fstab
fi
#安装WinMail
yum           -y       install       wget tar telnet net-tools mlocate bind-utils
wget          https://cdn.winmail.cn/download/winmail-pro-5.0-0728-x86_64.tar.gz         -cP       .
tar           -xf      winmail-pro-5.0-0728-x86_64.tar.gz                                -C        .
systemctl     stop     winmail
bash          ./winmail/install.sh
systemctl     restart  winmail
netstat       -plnt
#访问         http://mail.hanhongju.com:6080/




