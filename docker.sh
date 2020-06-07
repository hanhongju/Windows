#Docker安装脚本@Debian 10
#安装https更新源依赖包
apt   install   -y   apt-transport-https    ca-certificates     curl     gnupg-agent    software-properties-common
#添加docker官方GPG密钥
curl -fsSL https://download.docker.com/linux/debian/gpg      |    apt-key add -
#添加docker更新源
add-apt-repository   "deb [arch=amd64] https://download.docker.com/linux/debian   $(lsb_release -cs)   stable"
#安装docker
apt  update
apt  install   -y    docker-ce docker-ce-cli containerd.io   docker-compose
#查看docker版本
docker   run   hello-world
docker     --version
docker-compose    --version

