#创建KMS服务器用以激活 Windows 10 系统
apt     update
apt     install   -y   wget
yum     install   -y   wget
wget    https://github.com/Wind4/vlmcsd/releases/download/svn1113/binaries.tar.gz   -cP   /home/kms/
tar     -xf     /home/kms/binaries.tar.gz   -C   /home/kms/
cp      /home/kms/binaries/Linux/intel/static/vlmcsd-x64-musl-static      /usr/bin/vlmcsd
vlmcsd
ss      -plnt



#在Windows中用管理员身份登录Powershell输入以下代码
slmgr /skms  ali.hongju.live
slmgr /ato



#参考文献 https://www.wenzika.com/357.html


