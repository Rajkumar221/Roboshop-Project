color="\e[36m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

nodejs() {
echo -e "${color} Setup NodeJS repos ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file

echo -e "${color} Install NodeJS ${nocolor}"
yum install nodejs -y &>>$log_file

echo -e "${color} Add application User and app directory ${nocolor}"
useradd roboshop &>>$log_file
rm -rf ${app_path}
mkdir ${app_path}

echo -e "${color} Download the application code ${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip  &>>$log_file

echo -e "${color} Extract the file ${nocolor}"
cd ${app_path}
unzip /tmp/$component.zip &>>$log_file

echo -e "${color} download the dependencies. ${nocolor}"
cd ${app_path} &>>$log_file
npm install  &>>$log_file

echo -e "${color} Setup SystemD $component Service ${nocolor}"
cp /home/centos/Roboshop-Project/$component.service /etc/systemd/system/$component.service &>>$log_file

echo -e "${color} start $component service ${nocolor}"
systemctl daemon-reload &>>$log_file
systemctl enable $component  &>>$log_file
systemctl restart $component &>>$log_file

}

mongo_schema_setup() {
echo -e "\e[33m Copy MongoDB Repo file \e[0m"
cp /home/centos/Roboshop-Project/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>/tmp/roboshop.log

echo -e "\e[33m Install MongoDB Client \e[0m"
yum install mongodb-org-shell -y  &>>/tmp/roboshop.log

echo -e "\e[33m Load Schema \e[0m"
mongo --host mongodb-dev.devopsb73.store </app/schema/user.js  &>>/tmp/roboshop.log
}