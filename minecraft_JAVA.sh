#MineCraft JAVA版服务器搭建脚本@Debian 9
apt    update
apt    full-upgrade   -y
apt    autoremove     -y
apt    install        -y        wget unzip zip screen default-jdk nginx
#架设下载服务器
echo   'server {listen 80;listen [::]:80;root /home/;}'   >   /etc/nginx/sites-enabled/default
service   nginx   restart
#下载1.15.2版本mc服务器
wget      https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar     -cP     /home/mcserver/
#打开虚拟终端mc，后台托管mc
screen   -R      mc
cd       /home/mcserver/
java     -jar    server.jar    nogui
sed      -i     's/eula=false/eula=true/g'       eula.txt
java     -jar    server.jar    nogui
#关闭shell，连接服务器，开玩





#关闭所有screen终端和服务器
netstat  -plunt | grep 'java'
screen   -ls
screen   -S   mc   -X   quit


#备份服务器，将mcserver目录压缩为mcserver.zip文件
cd      /home/
zip     -q       mcserver.zip          -r     ./mcserver/


#到新服务器，上传备份文件至/home/并解压
rm      -rf     /home/mcserver/
unzip   -qo     /home/mcserver.zip     -d      /home/
#打开服务器终端，开玩





