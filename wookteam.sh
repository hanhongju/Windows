yum install -y     gcc gcc-c++ make kernel-devel
yum update  -y     kernel
yum localinstall  -y   http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
#添加安装源
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install -y     nginx php72w php72w-cli php72w-devel php72w-gd php72w-fpm php72w-mbstring php72w-pear php72w-xml php72w-xmlrpc php72w-common php72w-pdo php72w-mysqli

setenforce 0
systemctl enable   nginx php-fpm
systemctl start    nginx php-fpm






