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
cd             "C:\Windows\System32"
cscript.exe    slmgr.vbs    /ipk    W269N-WFGWX-YVC9B-4J6C9-T83GX
cscript.exe    slmgr.vbs    /skms          kms.03k.org
cscript.exe    slmgr.vbs    /ato

}




activate_LTSC_office () {
cd       "C:\Program Files\Microsoft Office\Office16"
cd       "C:\Program Files (x86)\Microsoft Office\Office16"
cscript   ospp.vbs    /dstatus
cscript   ospp.vbs    /sethst:kms.03k.org
cscript   ospp.vbs    /act
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




