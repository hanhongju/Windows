#Docker安装v2ray脚本@Debian 10
#定义站点地址
site=hostb.hongju.site
#拉取v2ray脚本并安装
apt      purge       -y      apache2
docker   rm    -f    v2ray
docker   run   -d    --rm --name v2ray -p 443:443 -p 80:80 -v $HOME/.caddy:/root/.caddy  pengchujin/v2ray_ws:0.10   $site V2RAY_WS 15448fce-7c71-11ea-bc55-0242ac130003
#显示信息
docker   logs    v2ray






