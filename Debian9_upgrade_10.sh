#Debian 9 升级为 Debian 10
apt update -y && apt upgrade -y && apt dist-upgrade -y
cp /etc/apt/sources.list /etc/apt/sources.list.bak
sed -i 's/stretch/buster/g' /etc/apt/sources.list 
cat /etc/apt/sources.list
apt update -y && apt upgrade -y && apt dist-upgrade -y
#查看当前系统版本
lsb_release -a
#查看当前nginx版本
curl -I 127.0.0.1
#查看当前php版本
php -v
