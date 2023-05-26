"\e[33mSetup NodeJS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

"\e[33m Install NodeJS\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

"\e[33m Add application User and app directory\e[0m"
useradd roboshop &>>/tmp/roboshop.log
mkdir /app 

"\e[33m Download the application code \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip  &>>/tmp/roboshop.log

"\e[33m Extract the file\e[0m"
cd /app 
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log

"\e[33m download the dependencies.\e[0m"
cd /app  &>>/tmp/roboshop.log
npm install  &>>/tmp/roboshop.log

"\e[33m Setup SystemD Catalogue Service\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

"\e[33m start catalogue service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue  &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log

"\e[33m Install mongodb shell\e[0m"
cp mongodb.repo etc/yum.repos.d/mongodg.repo &>>/tmp/roboshop.log
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

"\e[33m Load Schema\e[0m"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js &>>/tmp/roboshop.log