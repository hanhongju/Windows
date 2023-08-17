site=cloud1.thenote.live
apt         -y        update    
apt         -y        install      vsftpd net-tools
ipv4=$(ping -c 2 $site | head -2 | tail -1 | awk '{print $5}' | sed 's/[(:)]//g')
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




# Ftp服务器安装脚本 @ Debian 10 or Ubuntu 20.04
