# Ftp服务器安装脚本 @ Debian 10 or Ubuntu 20.04
apt update  -y
apt install -y vsftpd
ipv4=121.37.203.125
echo "
write_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
local_root=/home/ftp/
pasv_address=$ipv4
"  >>  /etc/vsftpd.conf
sed       -i       ''s/listen\=.*/listen\=YES/g''        /etc/vsftpd.conf
sed       -i       ''s/listen\_ipv6\=.*/listen\_ipv6\=NO/g''        /etc/vsftpd.conf
systemctl restart vsftpd
mkdir -p  /home/ftp/
chmod 777 /home/ftp/
useradd  -m  hongju   -d   /home/hongju/
passwd   hongju






