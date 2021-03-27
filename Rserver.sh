# Rserver安装 @ Debian 10 or Ubuntu 18


apt install -y gdebi-core r-base r-base-dev libatlas3-base
wget  -c  https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1106-amd64.deb
gdebi -n  rstudio-server-1.4.1106-amd64.deb
rstudio-server verify-installation


userdel hongju
useradd hongju
passwd  hongju


