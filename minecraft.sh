# MineCraft JAVA版服务器搭建脚本 @ Debian
apt      update
apt      install     -y     wget screen default-jdk
#下载1.15.2版本mc服务器文件
wget     https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar     -cP     /home/mcserver/
#打开虚拟终端，后台运行服务器
screen   -R      mc
cd       /home/mcserver/
java     -jar    server.jar    nogui
sed      -i     's/eula=false/eula=true/g'       eula.txt
java     -jar    server.jar    nogui
#关闭shell，连接服务器，开玩

#关闭所有screen终端和服务器
ss       -plnt | grep 'java'
screen   -ls
screen   -S   mc   -X   quit

#备份服务器
tar    -Pcf     /home/mc.tar      /home/mcserver/
#还原服务器
tar    -Pxf     /home/mc.tar









#Minecraft基岩版服务器架设@Debian 10
#安装常用软件包
apt    update
apt    install        -y   wget unzip zip libcurl4-openssl-dev
#下载基岩版mc服务器文件
wget    https://minecraft.azureedge.net/bin-linux/bedrock-server-1.14.60.5.zip      -cP     /home/
unzip   -qo   /home/bedrock-server-1.14.60.5.zip    -d    /home/mcserver/
chmod   -Rf    777    /home/
#启动服务器
cd /home/mcserver/
(LD_LIBRARY_PATH=. ./bedrock_server&)
#关闭shell，连接服务器，开玩

#关闭服务器
pkill   -9    bedrock_server

#备份服务器
tar    -Pcf     /home/mcworlds.tar      /home/mcserver/worlds/
#还原服务器
tar    -Pxf     /home/mcworlds.tar


#win10版MC本地数据库文件在：
#C:\Users\hongju\AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\minecraftWorlds








