#BestTrace4Linux 查看VPS回程节点@Debian 10
apt        update
apt        install    -y     unzip zip wget
mkdir      /home/besttrace
cd         /home/besttrace
wget       https://raw.githubusercontent.com/hanhongju/my_script/master/besttrace4linux.zip  
unzip      besttrace4linux.zip    -od    /home/besttrace
chmod      +x     besttrace
./besttrace       60.218.218.145




