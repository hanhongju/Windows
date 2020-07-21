#BestTrace4Linux 查看VPS回程节点@Debian 10
apt        update
apt        install    -y     unzip zip wget
wget       https://raw.githubusercontent.com/hanhongju/my_script/master/besttrace4linux.zip      -cP     /home/besttrace/
cd        /home/besttrace/
unzip     -qo      besttrace4linux.zip
chmod     -Rf      777      /home/
./besttrace        60.218.218.145


