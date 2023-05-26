echo -e "\e[33mdisable  defaul mysql \e[0m"
yum module disable mysql -y 

echo -e "\e[33m setup mysql repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[33m install mysql server\e[0m"
yum install mysql-community-server -y

echo -e "\e[33m set password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1

echo -e "\e[33m start mysql servicie \e[0m"
systemctl enable mysqld
systemctl start mysqld  