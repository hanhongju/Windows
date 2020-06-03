#MineCraft JAVA版服务器搭建脚本@Debian 9
apt update
apt full-upgrade   -y
apt autoremove     -y
apt install        -y     wget   unzip   zip    screen   default-jdk
#创建文件夹，搭建1.15.2版本服务器
mkdir     /home/mcserver/
wget      https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar     -O   /home/mcserver/server.jar
#启动服务器，更新最终许可文件
java   -jar    /home/mcserver/server.jar    nogui
sed    -i     's/eula=false/eula=true/g'   /home/mcserver/eula.txt
#打开虚拟终端mc，后台托管mc
screen   -S    mc
java   -jar    /home/mcserver/server.jar    nogui
#关闭shell，连接服务器，开玩


#关闭虚拟终端mc和服务器
screen -ls
screen -X -S mc quit
screen -ls


#备份服务器，将world目录压缩为world.zip文件
cd         /home/mcserver/world   
zip   -r   /home/world.zip      ./*   
#到新服务器，上传备份文件至/home/，创建mc文件夹,解压
rm -rf     /home/mcserver/world/
mkdir      /home/mcserver/world/
unzip   -o   /home/world.zip     -d     /home/mcserver/world
#打开服务器终端，开玩
