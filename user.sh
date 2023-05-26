echo -e "\e[33m Setup NodeJS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/roboshop.log

echo -e "\e[33m install nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m add user and app directory\e[0m"
useradd roboshop &>>/tmp/roboshop.log
rm -rf /app
mkdir /app 

echo -e "\e[33m download the app content \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip  &>>/tmp/roboshop.log
cd /app 
unzip /tmp/user.zip &>>/tmp/roboshop.log

echo -e "\e[33m download the dependencies\e[0m"
cd /app  &>>/tmp/roboshop.log
npm install  &>>/tmp/roboshop.log
 
echo -e "\e[33m setup systemd service\e[0m"
cp user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log

echo -e "\e[33m setup mongodb repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>/tmp/roboshop.log

echo -e "\e[33m install mongodb client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[33m Load schema \e[0m"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js &>>/tmp/roboshop.log

echo -e "\e[33m start user service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user 
systemctl start user