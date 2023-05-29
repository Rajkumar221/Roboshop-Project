component=catalogue
color="\e[33m"
nocolor="\e[0m"

echo -e "${color} Setup NodeJS repos ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${color} Install NodeJS ${nocolor}"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "${color} Add application User and app directory ${nocolor}"
useradd roboshop &>>/tmp/roboshop.log
rm -rf /app
mkdir /app 

echo -e "${color} Download the application code ${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip  &>>/tmp/roboshop.log

echo -e "${color} Extract the file ${nocolor}"
cd /app 
unzip /tmp/$component.zip &>>/tmp/roboshop.log

echo -e "${color} download the dependencies. ${nocolor}"
cd /app  &>>/tmp/roboshop.log
npm install  &>>/tmp/roboshop.log

echo -e "${color} Setup SystemD $component Service ${nocolor}"
cp /home/centos/Roboshop-Project/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log

echo -e "${color} start $component service ${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable $component  &>>/tmp/roboshop.log
systemctl restart $component &>>/tmp/roboshop.log

echo -e "${color} Install mongodb shell ${nocolor}"
cp mongodb.repo etc/yum.repos.d/mongodg.repo &>>/tmp/roboshop.log
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "${color} Load Schema ${nocolor}"
mongo --host mongodb-dev.devops73.online </app/schema/$component.js &>>/tmp/roboshop.log