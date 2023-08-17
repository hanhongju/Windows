if        [[   $(free  -m  |  awk   'NR==3{print $2}'   2>&1)    >   3000   ]]
then      echo     "已经有SWAP，无需重复配置"
else      echo     "添加SWAP空间，大小4000M"
          dd       if=/dev/zero of=/mnt/swap bs=1M count=4000
          mkswap   /mnt/swap
          swapon   /mnt/swap
          echo     '/mnt/swap swap swap defaults 0 0'      >>       /etc/fstab
fi
echo      "mail"       >      /etc/hostname
echo      "127.0.0.1   mail.hanhongju.com   mail   localhost"    >    /etc/hosts
sysctl    kernel.hostname=mail.hanhongju.com
apt       -y     update
apt       -y     install tar gzip wget
wget      -c     https://github.com/iredmail/iRedMail/archive/1.6.2.tar.gz
tar       -xf    1.6.2.tar.gz     -C.
bash      ./iRedMail-1.6.2/iRedMail.sh




# iRedMail @ Debian 11
#访问      http://mail.hanhongju.com/mail/




