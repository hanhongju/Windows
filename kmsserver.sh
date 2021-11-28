#创建KMS服务器用以激活 Windows 10 系统和 Office 2016
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
#激活Windows 10
slmgr -skms  tx.thenote.site
slmgr -ato




#激活64位Office 2016
cd "C:\Program Files\Microsoft Office\Office16"
cscript ospp.vbs /sethst:tx.thenote.site
cscript ospp.vbs /act
cscript ospp.vbs /dstatus



#参考文献
#https://www.wenzika.com/357.html
#http://www.kaixinit.com/info/maintenance/3031.html





