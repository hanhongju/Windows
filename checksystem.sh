if     [[  $(grep  PRETTY_NAME=   /etc/os-release)   =~    'CentOS Linux 8'       ]]   ;then   SYSTEM='CentOS8'
elif   [[  $(grep  PRETTY_NAME=   /etc/os-release)   =~    'Debian GNU/Linux 10'  ]]   ;then   SYSTEM='Debian10'
fi
echo $SYSTEM




