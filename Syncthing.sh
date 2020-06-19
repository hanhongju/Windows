#Syncthing安装脚本@Debian 10
apt   update
apt   full-upgrade   -y
apt   autoremove     -y
apt   install        -y    tar wget unzip zip screen
wget   -c      https://github.com/syncthing/syncthing/releases/download/v1.6.1/syncthing-linux-amd64-v1.6.1.tar.gz       -P       /home/
#安装文件
mkdir     /home/sync/
cd        /home/sync/
tar       -zxf           /home/syncthing-linux-amd64-v1.6.1.tar.gz           
cd        syncthing-linux-amd64-v1.6.1
cp        syncthing      /usr/bin/syncthing
chmod     +x             /usr/bin/syncthing
rm        -rf            /home/sync/
#运行程序，生成配置文件
screen    -R     sync
/usr/bin/syncthing
#关闭shell，重新连接
#修改配置文件
sed       -i        's/127.0.0.1/0.0.0.0/g'       /root/.config/syncthing/config.xml
#后台运行sync
pkill      syncthing
screen    -R     sync
/usr/bin/syncthing
#关闭shell，连接IP:8384，webui配置同步文件夹



#关闭所有screen终端和服务器
netstat -tulpna | grep 'syncthing'
screen -ls
pkill screen





