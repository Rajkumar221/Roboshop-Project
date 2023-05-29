color="\e[36m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log?"
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
echo -e "${color} Copy MongoDB Repo file ${nocolor}"
cp /home/centos/Roboshop-Project/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>>$log_file

echo -e "${color} Install MongoDB Client ${nocolor}"
yum install mongodb-org-shell -y  &>>$log_file

echo -e "${color} Load Schema ${nocolor}"
mongo --host mongodb-dev.devopsb73.store <${app_path}/schema/user.js  &>>$log_file
}

maven() {
echo -e "${color} install maven${nocolor}"
yum install maven -y &>>$log_file

echo -e "${color} Add application User and app directory ${nocolor}"
useradd roboshop &>>$log_file
rm -rf ${app_path}
mkdir ${app_path} 

echo -e "${color} download the content ${nocolor}"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip  &>>$log_file
cd ${app_path} 
unzip /tmp/shipping.zip &>>$log_file

echo -e "${color} extracat the file ${nocolor}"
cd ${app_path}  &>>$log_file
mvn clean package &>>$log_file
mv target/shipping-1.0.jar shipping.jar  &>>$log_file

echo -e "${color} reload ${nocolor}"
systemctl daemon-reload &>>$log_file

echo -e "${color} install mysql client ${nocolor}"
yum install mysql -y  &>>$log_file

echo -e "${color} load schema ${nocolor}"
mysql -h mysql-dev.devops73.online -uroot -pRoboShop@1 < ${app_path}/schema/shipping.sql  &>>$log_file

echo -e "${color} setup systemd file ${nocolor}"
cp /home/centos/Roboshop-Project/shipping.service /etc/systemd/system/shipping.service

echo -e "${color} start shipping service ${nocolor}"
systemctl enable shipping &>>$log_file
systemctl restart shipping &>>$log_file
}

python() {
    echo -e "${color} install python ${nocolor}"
yum install python36 gcc python3-devel -y &>>$log_file

echo -e "${color} add user ${nocolor}"
useradd roboshop &>>$log_file

echo -e "${color} make app directory ${nocolor}"
rm -rf /app &>>$log_file
mkdir /app &>>$log_file
 
echo -e "${color} download the app content ${nocolor}"
curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip  &>>$log_file
unzip /tmp/$component.zip &>>$log_file

echo -e "${color} install dependencies ${nocolor}"
cd /app  &>>$log_file
pip3.6 install -r requirements.txt &>>$log_file

echo -e "${color} setup systemd service ${nocolor}"
cp $component.service /etc/systemd/system/$component.service &>>$log_file

echo -e "${color} reload ${nocolor}"
systemctl daemon-reload &>>$log_file
systemctl restart $component
}