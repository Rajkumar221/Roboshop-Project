source common.sh

echo -e "\e[33mdisable  defaul mysql \e[0m"
yum module disable mysql -y  &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[33m setup mysql repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[33m install mysql server\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[33m set password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[33m start mysql servicie \e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl start mysqld   &>>/tmp/roboshop.logs
stat_check $?