#BBR加速控制拥堵
#一键检测VPS架构类型：Openvz、KVM、Xen?
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/code/master/vm_check.sh && bash vm_check.sh
#OpenVZ架构升级内核安装BBR加速@CentOS7系统：
wget https://github.com/tcp-nanqinlang/lkl-rinetd/releases/download/1.1.0/tcp_nanqinlang-rinetd-centos-multiNIC.sh && bash tcp_nanqinlang-rinetd-centos-multiNIC.sh
#KVM架构升级内核安装BBR加速：
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh


