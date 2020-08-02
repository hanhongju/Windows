

site=mail.hongju.fun

apt    update
apt    full-upgrade    -y
apt    autoremove      -y
apt    purge           -y         apache2 nginx
apt    install         -y         python3-pip net-tools postfix postfix-mysql postfix-doc mailutils mariadb-server
#安装Certbot
pip3   install     cryptography --upgrade
pip3   install     certbot
#申请SSL证书
certbot    certonly    --standalone    --agree-tos     -n     -d      $site     -m    86606682@qq.com 
rm       -rf     /home/keys/
mkdir    -p      /home/keys/
cp       /etc/letsencrypt/live/$site/fullchain.pem       /home/keys/fullchain.pem
cp       /etc/letsencrypt/live/$site/privkey.pem         /home/keys/privkey.pem
cp       /home/keys/fullchain.pem            /etc/ssl/certs/ssl-cert-snakeoil.pem
cp       /home/keys/privkey.pem              /etc/ssl/private/ssl-cert-snakeoil.key
chmod    -Rf     777       /home/






#初始化数据库
mysql_secure_installation

#修改数据库登录方式
mysql         -uroot     -pfengkuang     -e      "update mysql.user set plugin='mysql_native_password' where User='root'"
#登录数据库，创建表，添加数据
mysql   -uroot   -pfengkuang


DROP DATABASE mailserver;
CREATE DATABASE mailserver;
SHOW DATABASEs;
USE mailserver;

CREATE TABLE `virtual_domains` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `virtual_users` (
  `id` int(11) NOT NULL auto_increment,
  `domain_id` int(11) NOT NULL,
  `password` varchar(106) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `virtual_aliases` (
  `id` int(11) NOT NULL auto_increment,
  `domain_id` int(11) NOT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `mailserver`.`virtual_domains`
  (`id` ,`name`)
VALUES
  ('1', 'hongju.fun');
SELECT * FROM mailserver.virtual_domains;

INSERT INTO `mailserver`.`virtual_users`
  (`id`, `domain_id`, `password` , `email`)
VALUES
  ('1', '1', 'fengkuang', 'root@hongju.fun');
SELECT * FROM mailserver.virtual_users;

INSERT INTO `mailserver`.`virtual_aliases`
  (`id`, `domain_id`, `source`, `destination`)
VALUES
  ('1', '1', 'hj@hongju.fun', 'root@hongju.fun');
SELECT * FROM mailserver.virtual_aliases;

exit





cp    /etc/postfix/main.cf     /etc/postfix/main.cf.orig
sed      -i       '/myhostname/d'           /etc/postfix/main.cf
echo  "myhostname = hongju.fun"    >>       /etc/postfix/main.cf





















