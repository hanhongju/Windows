# Ftp服务器安装脚本 @ Debian 10 or Ubuntu 20.04
# 定义服务器地址
server=cloud1.thenote.live
# 安装
sudo        su
apt         -y        update    
apt         -y        install      vsftpd net-tools
ipv4=$(ping -c 2 $server | head -2 | tail -1 | awk '{print $5}' | sed 's/[(:)]//g')
echo        $ipv4
echo                  "pasv_address=$ipv4"             >>            /etc/vsftpd.conf
sed         -i        's/^#\(write_enable=\)/\1/g'                   /etc/vsftpd.conf
sed         -i        's/\(listen=\).*/\1YES/g'                      /etc/vsftpd.conf
sed         -i        's/listen_ipv6=.*/listen_ipv6=NO/g'            /etc/vsftpd.conf
useradd     -m        hhj      -d      /usr/hhj/
echo        -e        "hhj\nhhj"           |             passwd  hhj
systemctl   enable    vsftpd
systemctl   restart   vsftpd
netstat     -plnt




