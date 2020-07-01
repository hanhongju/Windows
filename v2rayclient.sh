#v2rayclient安装脚本@Debian 10




#Docker安装v2ray @Debian 10
#一键安装docker
apt update && apt install -y curl && bash -c "$(curl -sL https://get.docker.com)"
#下载v2ray
docker  pull  v2ray/official
mkdir   /etc/v2ray
#导入节点信息文件
cp        -f       /home/hj/config.json                         /home/config.json
cp        -f       /home/config.json                            /etc/v2ray/config.json
#读取节点信息，启动容器
docker container stop v2ray
docker container rm v2ray
docker run   -d   --name   v2ray   -v    /etc/v2ray:/etc/v2ray    -p   8000:8000   v2ray/official   v2ray   -config=/etc/v2ray/config.json
docker container restart v2ray
docker container ls
#回显容器信息




#手动安装v2ray @Debian 10
#下载v2ray，如不能联网，手动下载v2ray.zip至/home目录或/home/hj目录，上传配置文件config.json至/home目录或/home/hj目录
wget        https://github.com/v2ray/v2ray-core/releases/download/v4.23.4/v2ray-linux-64.zip     -O     /home/v2ray-linux-64.zip
#安装v2ray文件
apt   update
apt   install    -y          unzip zip net-tools wget
mkdir    /usr/bin/v2ray/
mkdir    /etc/v2ray/
cp        -f       /home/hj/v2ray-linux-64.zip                  /home/v2ray-linux-64.zip
unzip     -o       /home/v2ray-linux-64.zip           -d        /usr/bin/v2ray/
#配置v2ray服务
cp        -f       /usr/bin/v2ray/systemd/v2ray.service         /etc/systemd/system/v2ray.service
systemctl     daemon-reload
systemctl     enable      v2ray
#导入节点信息文件
cp        -f       /home/hj/config.json                         /home/config.json
cp        -f       /home/config.json                            /etc/v2ray/config.json
#读取节点信息，重启
service    v2ray     restart     
sleep 1s
netstat  -plunt | grep 'v2ray'
#回显v2ray监听端口




#设置tsocks透明代理
apt  install    -y         tsocks
echo '
server       =  127.0.0.1
server_type  =  5
server_port  =  8000
default_user =  none
default_pass =  none
'          >              /etc/tsocks.conf
#在wget之前加上tsocks以使其通过代理



