#syncthing安装脚本@Debian 10
apt   update
apt   full-upgrade   -y
apt   autoremove     -y
apt   install        -y    tar wget unzip zip net-tools

#安装网页文件
wget      https://github.com/syncthing/syncthing/releases/download/v1.6.1/syncthing-linux-amd64-v1.6.1.tar.gz     -cP     /home/
cd        /home/
tar       -zxf        syncthing-linux-amd64-v1.6.1.tar.gz           
cd        syncthing-linux-amd64-v1.6.1
cp        syncthing                                           /usr/bin/syncthing
cp        etc/linux-systemd/system/syncthing@.service         /etc/systemd/system/syncthing@.service
#生成配置文件，配置系统服务
systemctl    enable    syncthing@root.service
systemctl    start     syncthing@root.service
sleep 5s
systemctl    stop      syncthing@root.service
#修改配置文件，启动服务
sed         -i        's/127.0.0.1/0.0.0.0/g'          /root/.config/syncthing/config.xml
systemctl    restart   syncthing@root.service
sleep 5s
netstat     -plunt | grep 'syncthing'
#回显syncthing监听端口



