

apt    update
apt    full-upgrade    -y
apt    autoremove      -y
apt    purge           -y         apache2 nginx
apt    install         -y         python3-pip net-tools postfix postfix-mysql postfix-doc mailutils


