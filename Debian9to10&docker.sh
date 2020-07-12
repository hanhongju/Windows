#Debian 9 升级为 Debian 10
apt   update
apt   full-upgrade    -y
cp    /etc/apt/sources.list           /etc/apt/sources.list.bak
sed   -i    's/stretch/buster/g'      /etc/apt/sources.list 
apt   update
apt   full-upgrade    -y
apt   autoremove      -y



#Docker安装脚本@Debian 10
apt  update
apt  install  -y      apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl  -fsSL     https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/debian    $(lsb_release -cs)    stable"
apt  update
apt  install  -y      docker-ce docker-ce-cli containerd.io
docker run hello-world
lsb_release   -a
#显示系统新版本信息



