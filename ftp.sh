# Ftp服务器安装脚本 @ Debian 10 or Ubuntu 20.04
apt update  -y
apt install -y vsftpd
echo '
write_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
local_root=/home/ftp/
'  >>  /etc/vsftpd.conf
systemctl restart vsftpd
mkdir -p  /home/ftp/
chmod 777 /home/ftp/
useradd  -m  hongju   -d   /home/hongju/
passwd   hongju






