#Syncthing安装脚本@Debian 10
apt   update
apt   install     -y    tar   screen
#wget   -c      https://github.com/syncthing/syncthing/releases/download/v1.6.1/syncthing-linux-amd64-v1.6.1.tar.gz       -O       /home/syncthing.tar.gz
#安装文件
mv        /home/syncthing-linux-amd64-v1.6.1.tar.gz               /home/syncthing.tar.gz 
mkdir     /home/sync/
cd           /home/sync/
tar       -zxf       /home/syncthing.tar.gz           
cd        syncthing-linux-amd64-v1.6.1
cp        syncthing             /usr/bin/syncthing
rm      -rf          /home/sync/
chmod               +x                    /usr/bin/syncthing
#运行程序，生成配置文件
/usr/bin/syncthing
#修改配置文件
sed   -i     's/127.0.0.1/0.0.0.0/g'     /root/.config/syncthing/config.xml
#运行
screen   -R    sync
/usr/bin/syncthing
