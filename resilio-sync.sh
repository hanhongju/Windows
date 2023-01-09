



sudo       su
apt        -y      update    
apt        -y      install    wget
wget       https://download-cdn.resilio.com/2.7.3.1381/Debian/resilio-sync_2.7.3.1381-1_amd64.deb    -O    resilio-sync.deb
dpkg       -i      resilio-sync.deb
systemctl  enable  resilio-sync
systemctl  start   resilio-sync
netstat    -plnt




