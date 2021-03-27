apt update
apt install -y r-base r-base-dev libatlas3-base gdebi-core
wget -c https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1106-amd64.deb
gdebi -n rstudio-server-1.4.1106-amd64.deb
rstudio-server restart

useradd  hongju
mkdir /home/hongju/
chown -R hongju /home/hongju/

