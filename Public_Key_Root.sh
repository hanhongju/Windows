#Public_Key_Install_And_Allow_Root
mkdir         /root/.ssh/
echo    '
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuzUhxvKlwt9dPfNGcd+W05OWJNf7du0BQBp1TKRMH51LTbszLSSBA9mZdxnhiOcSVF3XX6zgVuUEg15EEkOqcBhhaMXaxZ/0rlsXXpR4qY4sjOOngK5T6JRcNCNyzJbE0VfsYPm31q1U9lvBgyU4sSjaJ0cU0ErOP5Y3mWiz5MjnRFCqu1WDJbRh/PZiOjlwLjcWIrUwIPCiAXh3Rw5jh2La+mExG4GBtDrizTbJKYabrrWrXsfafM65+ZQ4H6nXhW+Ce33SIGZHa+28yaFGNDcr9CwpYPes1CD2b8lVUKHmRQkeVRD08WflZ6iT8xhUydx1Ch6UFBMgB672jFozuGGdrYgRv3Fkj3us5MP40b1qkVRwg37LFxLBwC+DNWNnlKazjYx5iI4BLyHUuJGyuRZ/BAT9qd8DCy9MaRvE4Kvo2p6Git8HBjbS1XnJTnrhrtpc4JUfL4NiQeJYh3b2PvfEQNWz3/4B9MeWKwXJqAXEy+TAwQITxI+Ka5dR3T10=
'       >     /root/.ssh/authorized_keys
sed           -i          "s/PermitRootLogin .*/PermitRootLogin yes/g"                        /etc/ssh/sshd_config
sed           -i          "s/PasswordAuthentication .*/PasswordAuthentication yes/g"          /etc/ssh/sshd_config
systemctl     restart     sshd





#安装公钥，开启ROOT密码登录
