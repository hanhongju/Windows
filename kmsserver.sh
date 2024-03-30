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




activate_windows () {
#在Windows中用管理员身份登录Powershell输入以下代码激活Windows 10
slmgr    /ipk    TFP9Y-VCY3P-VVH3T-8XXCC-MF4YK
slmgr    /skms   kms.03k.org
slmgr    /ato

#在Windows中用管理员身份登录Powershell输入以下代码激活Windows 11
slmgr    /ipk    NPPR9-FWDCX-D2C8J-H872K-2YT43
slmgr    /skms   kms.03k.org
slmgr    /ato

}




activate_office () {
cd       "C:\Program Files\Microsoft Office\Office16"
cd       "C:\Program Files (x86)\Microsoft Office\Office16"
cscript   ospp.vbs    /sethst:kms.03k.org
cscript   ospp.vbs    /act
cscript   ospp.vbs    /dstatus
#cscript  ospp.vbs    /unpkey:XXXXX

}




directsetup () {
apt     -y    install    wget
wget    https://raw.githubusercontent.com/hanhongju/my_script/master/kmsserver.sh    -O    setup.sh
bash    setup.sh

}




#参考文献
#https://www.wenzika.com/357.html
#http://www.kaixinit.com/info/maintenance/3031.html




