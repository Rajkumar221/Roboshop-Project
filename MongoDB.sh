#Mongodb setup

echo -e "\e[33mCopy mongodb repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33minstall mongodb server\e[0m"
yum install mongodb-org -y  &>>/tmp/roboshop.log

## Modify the config file 

echo -e "\e[33mstart mongodb service\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
