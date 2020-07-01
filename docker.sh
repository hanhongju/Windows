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





site=
#安装docker
apt update && apt install -y curl && bash -c "$(curl -sL https://get.docker.com)"
#拉取v2ray脚本并安装
docker run -d --rm --name v2ray -p 443:443 -p 80:80 -v $HOME/.caddy:/root/.caddy  pengchujin/v2ray_ws:0.10 $site V2RAY_WS 15448fce-7c71-11ea-bc55-0242ac130003
#显示信息
docker logs v2ray
