#创建KMS服务器用以激活 Windows 10 系统
apt     -y     update    
apt     -y     install    wget
wget    -c     https://github.com/Wind4/vlmcsd/releases/download/svn1113/binaries.tar.gz   -P   /home/kms/
tar     -xf    /home/kms/binaries.tar.gz   -C   /home/kms/
\cp     -f     /home/kms/binaries/Linux/intel/static/vlmcsd-x86-musl-static     /usr/bin/vlmcsd
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




#在Windows中用管理员身份登录Powershell输入以下代码
#开启微软高级保护服务 MAPS
Set-MpPreference -MAPSReporting 2
Get-MpPreference
#激活Windows 10
slmgr -skms  tx.thenote.live
slmgr -ato




#参考文献
#https://www.wenzika.com/357.html
#http://www.kaixinit.com/info/maintenance/3031.html





