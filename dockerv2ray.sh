#Docker安装v2ray脚本@Debian 10
#安装docker
apt update && apt install -y curl && apt purge -y apache2 && bash -c "$(curl -sL https://get.docker.com)"
apt purge -y apache2
#定义站点地址
echo    "
请输入此VPS的IP对应的域名地址：
Now type in your VPS's domain:
"
read    site
#拉取v2ray脚本并安装
docker rm -f v2ray
docker run -d --rm --name v2ray -p 443:443 -p 80:80 -v $HOME/.caddy:/root/.caddy  pengchujin/v2ray_ws:0.10   $site V2RAY_WS 15448fce-7c71-11ea-bc55-0242ac130003
#显示信息
docker logs v2ray






