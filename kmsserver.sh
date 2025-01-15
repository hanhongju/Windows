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
cscript.exe    slmgr.vbs    /skms   kms.03k.org
cscript.exe    slmgr.vbs    /ato

}




activate_LTSC_office () {
cd             "C:\Program Files\Microsoft Office\Office16"
cd             "C:\Program Files (x86)\Microsoft Office\Office16"
cscript.exe    ospp.vbs    /dstatus
cscript.exe    ospp.vbs    /inpkey:XJ2XN-FW8RK-P4HMP-DKDBV-GCVGB
cscript.exe    ospp.vbs    /sethst:kms.03k.org
cscript.exe    ospp.vbs    /act
#cscript.exe   ospp.vbs    /unpkey:XXXXX

}





#参考文献
# https://www.wenzika.com/357.html
# http://www.kaixinit.com/info/maintenance/3031.html
# WINDOWS密钥https://learn.microsoft.com/zh-cn/windows-server/get-started/kms-client-activation-keys?tabs=server2025%2Cwindows1110ltsc%2Cversion1803%2Cwindows81
# OFFICE密钥https://learn.microsoft.com/zh-cn/office/volume-license-activation/gvlks
