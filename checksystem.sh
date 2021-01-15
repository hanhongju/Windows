if     [[  $(grep  PRETTY_NAME=   /etc/os-release)   =~    'CentOS Linux 8'       ]]   ;then   SYSTEM='CentOS  8'
elif   [[  $(grep  PRETTY_NAME=   /etc/os-release)   =~    'Debian GNU/Linux 10'  ]]   ;then   SYSTEM='Debian  10'
fi
echo $SYSTEM




