CentOs 7.5-7.9


yum           -y     install wget tar telnet net-tools mlocate bind-utils
wget          https://cdn.winmail.cn/download/winmail-pro-5.0-0728-x86_64.tar.gz        -P          /home/
rm            -rf     /home/wordpress/
tar           -xf     /home/winmail-pro-5.0-0728-x86_64.tar.gz                          -C          /home/
systemctl     stop winmail
bash          /home/winmail/install.sh





