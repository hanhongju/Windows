#新系统环境设置
#更换软件源，阿里软件更新服务器
\cp     -f      /etc/apt/sources.list         /etc/apt/sources.list_backup
echo '
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
'         >             /etc/apt/sources.list
#新系统更新软件
apt   -y   update
apt   -y   full-upgrade
apt   -y   autoremove
apt   -y   install                         wget curl net-tools gcc make perl zip unzip vim axel fcitx daemon python3-gpg ffmpeg steam-installer
apt   -y   install                         qbittorrent libavcodec-extra hardinfo  ttf-mscorefonts-installer  ubuntu-restricted-extras
apt   -y   install                         r-base libjpeg62

#设定网络容忍度
sed    -i    "s/lcp-echo-failure\ 4/lcp-echo-failure\ 15/g"       /etc/ppp/options
#禁用wifi电源节省管理
sed    -i    "s/wifi.powersave\ =\ 3/wifi.powersave\ =\ 2/g"       /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
#删除dhcp服务器ipv6功能
sed    -i    "s/dhcp6.name-servers,\ dhcp6.domain-search,\ dhcp6.fqdn,\ dhcp6.sntp-servers,//g"      /etc/dhcp/dhclient.conf
#禁用ipv6
echo   "net.ipv6.conf.all.disable_ipv6 = 1"            >>   /etc/sysctl.conf
echo   "net.ipv6.conf.default.disable_ipv6 = 1"        >>   /etc/sysctl.conf
echo   "net.ipv6.conf.lo.disable_ipv6 = 1"             >>   /etc/sysctl.conf
sysctl -p


#添加SWAP缓存空间
if        [[   $(free  -m  |  awk   'NR==3{print $2}'   2>&1)    >   7000   ]]
then      echo   ''已经有SWAP，无需重复配置''
else      echo   ''添加SWAP空间，大小8000M''
          dd       if=/dev/zero of=/mnt/swap bs=1M count=8000
          mkswap   /mnt/swap
          swapon   /mnt/swap
          echo    '/mnt/swap swap swap defaults 0 0'      >>       /etc/fstab
fi


#卸载tint自带输入法，安装谷歌输入法
pkill      tint2
apt   -y   purge     ibus tint2
apt   -y   install   fcitx-bin fcitx-table  fcitx-googlepinyin


#安装R studio，到此网址查询Rstudio最新版本 https://rstudio.com/products/rstudio/download/
wget     -c      https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5042-amd64.deb      -P      /home/downloads/
dpkg     -i      /home/downloads/rstudio*.deb


#安装Finalshell
wget     -c     http://www.hostbuf.com/downloads/finalshell_install_linux.sh
bash     finalshell_install_linux.sh






