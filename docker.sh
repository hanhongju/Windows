#Docker一键安装脚本@Debian 10
apt update && apt install -y curl && bash -c "$(curl -sL https://get.docker.com)"




#Docker安装v2rayclient @Debian 10
#导入节点信息文件
cp        -f       /home/hj/config.json                         /home/config.json
cp        -f       /home/config.json                            /etc/v2rayconfig.json
#读取节点信息，启动容器
docker    rm    -f      v2ray
docker    run   -d    --name    v2ray    -v    /etc:/etc/v2ray    -p   8000:8000   v2ray/official   v2ray   -config=/etc/v2ray/v2rayconfig.json
docker    container    ls
#回显容器信息






#Docker安装v2ray+tls server@Debian 10
apt    update
apt    install    -y       curl
apt    purge      -y       apache2
#定义站点地址
site=<domain>
#拉取v2ray脚本并安装
docker    rm    -f     v2ray
docker    run   -d   --rm --name v2ray -p 443:443 -p 80:80 -v $HOME/.caddy:/root/.caddy  pengchujin/v2ray_ws:0.10   $site V2RAY_WS 15448fce-7c71-11ea-bc55-0242ac130003  
sleep     3s
docker    logs         v2ray
docker    container    ls
#显示服务器配置



