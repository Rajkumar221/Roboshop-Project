#Mongodb setup
source common.sh

echo -e "\e[33mCopy mongodb repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log
stat_check $? 

echo -e "\e[33minstall mongodb server\e[0m"
yum install mongodb-org -y  &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[33m Update listen address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat_check $?

echo -e "\e[33mstart mongodb service\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
stat_check $?