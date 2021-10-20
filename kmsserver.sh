#创建KMS服务器用以激活 Windows 10 系统
apt     -y     update    
apt     -y     install    wget
yum     -y     install    wget
wget    -c     https://github.com/Wind4/vlmcsd/releases/download/svn1113/binaries.tar.gz   -P   /home/kms/
tar     -Pxf   /home/kms/binaries.tar.gz   -C   /home/kms/
\cp     -f     /home/kms/binaries/Linux/intel/static/vlmcsd-x86-musl-static     /usr/bin/vlmcsd
vlmcsd




#在Windows中用管理员身份登录Powershell输入以下代码
slmgr -skms  ali.thenote.site
slmgr -ato



#参考文献 https://www.wenzika.com/357.html





