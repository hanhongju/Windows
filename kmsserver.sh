apt     -y     update
apt     -y     install    wget
wget    -c     https://github.com/Wind4/vlmcsd/releases/download/svn1113/binaries.tar.gz
tar     -xf    binaries.tar.gz   -C.
cp      -f     ./binaries/Linux/intel/static/vlmcsd-x86-musl-static     /usr/bin/vlmcsd
echo    '
[Unit]
Description=KMS server
[Service]
Type=forking
PIDFile=/var/run/vlmcsd.pid
ExecStart=/usr/bin/vlmcsd -p /var/run/vlmcsd.pid
Restart=on-failure
[Install]
WantedBy=multi-user.target
'             >            /etc/systemd/system/vlmcsd.service
systemctl     daemon-reload
systemctl     enable       vlmcsd
systemctl     restart      vlmcsd
netstat       -plnt




activeinwindows () {
#在Windows中用管理员身份登录Powershell输入以下代码激活Windows 10
slmgr -skms  kms.03k.org
slmgr -ato

}




directsetup () {
apt     -y    install    wget
wget    https://raw.githubusercontent.com/hanhongju/my_script/master/kmsserver.sh    -O    setup.sh
bash    setup.sh

}




#创建KMS服务器用以激活 Windows 10 系统
#参考文献
#https://www.wenzika.com/357.html
#http://www.kaixinit.com/info/maintenance/3031.html




