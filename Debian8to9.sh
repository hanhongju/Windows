#Debian 8 升级为 Debian 9
apt   update
apt   full-upgrade    -y
cp    /etc/apt/sources.list           /etc/apt/sources.list.bak
sed   -i    's/jessie/stretch/g'      /etc/apt/sources.list
apt   update
apt   full-upgrade    -y    --fix-missing
apt   autoremove      -y
lsb_release   -a
#显示系统新版本信息


#Debian8一键升级Debian9

#apt update && apt install -y curl && bash -c "$(curl -sL https://git.io/JJOVe)"


