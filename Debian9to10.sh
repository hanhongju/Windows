#Debian 9 升级为 Debian 10
apt   update
apt   full-upgrade    -y
cp    /etc/apt/sources.list           /etc/apt/sources.list.bak
sed   -i    's/stretch/buster/g'      /etc/apt/sources.list 
apt   update
apt   full-upgrade    -y    --fix-missing
apt   autoremove      -y

