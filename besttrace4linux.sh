#BestTrace4Linux 查看VPS回程节点@Debian 10
apt        update
apt        install    -y     unzip zip wget
cd         /home/
wget       -c      https://raw.githubusercontent.com/hanhongju/my_script/master/besttrace4linux.zip  
unzip      -qo     besttrace4linux.zip    -d    /home/besttrace/
chmod      -Rf         777           /home/
./besttrace/besttrace       60.218.218.145




