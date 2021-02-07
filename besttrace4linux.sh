#BestTrace4Linux 查看VPS回程节点@Debian 10
apt       update
apt       install    -y     unzip wget
wget      https://github.com/zhucaidan/BestTrace-Linux/raw/master/besttrace4linux.zip      -cP     /home/besttrace/
unzip     -qo      /home/besttrace/besttrace4linux.zip     -d     /home/besttrace/
chmod     -Rf      777      /home/besttrace/
/home/besttrace/besttrace   60.218.218.145





