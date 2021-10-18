# MineCraft JAVA版服务器搭建脚本 @ Debian
apt      -y      update    
apt      -y      install      wget screen default-jdk
#下载mc服务器1.16.5
wget     -c      https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar     -P     /home/mcserverjava/
#打开虚拟终端，后台运行服务器
screen   -R      mc
cd       /home/mcserverjava/
java     -jar    server.jar    nogui
sed      -i     's/eula=false/eula=true/g'       eula.txt
java     -jar    server.jar    nogui
#关闭shell开玩

#关闭所有screen终端和服务器
ss       -plnt | grep 'java'
screen   -ls
screen   -S   mc   -X   quit

#备份服务器
tar    -Pcf     /home/mcjava.tar      /home/mcserverjava/
#还原服务器
tar    -Pxf     /home/mcjava.tar









# Minecraft基岩版服务器架设 @ Debian
#安装常用软件包
apt    update
apt    install        -y   wget unzip zip libcurl4-openssl-dev
#下载基岩版mc服务器文件
wget    https://minecraft.azureedge.net/bin-linux/bedrock-server-1.14.60.5.zip      -cP     /home/
#wget   https://img.zeruns.tech/down/bedrock-server-1.16.20.03.zip      -cP     /home/
unzip   -qo   /home/bedrock-server-1.14.60.5.zip    -d    /home/mcserverbedrock/
chmod   -Rf    777    /home/
#启动服务器
cd /home/mcserverbedrock/
(LD_LIBRARY_PATH=. ./bedrock_server&)
#关闭shell开玩

#关闭服务器
pkill   -9    bedrock_server

#备份服务器
tar    -Pcf     /home/mcbedrockworlds.tar      /home/mcserverbedrock/worlds/
#还原服务器
tar    -Pxf     /home/mcbedrockworlds.tar

# 官网下载地址
# https://www.minecraft.net/zh-hans/download
# Win10版MC本地数据库文件在
# C:\Users\hongju\AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\minecraftWorlds








