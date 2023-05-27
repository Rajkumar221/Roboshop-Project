echo -e "\e[33m install maven\e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "\e[33m add user and app directory \e[0m"
useradd roboshop &>>/tmp/roboshop.log
rm -rf /app
mkdir /app 

echo -e "\e[33m download the content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip  &>>/tmp/roboshop.log
cd /app 
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[33m extracat the file \e[0m"
cd /app  &>>/tmp/roboshop.log
mvn clean package &>>/tmp/roboshop.logs
mv target/shipping-1.0.jar shipping.jar  &>>/tmp/roboshop.log

echo -e "\e[33m reload \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[33m install mysql client \e[0m"
yum install mysql -y  &>>/tmp/roboshop.log

echo -e "\e[33m load schema \e[0m"
mysql -h mysql-dev.devops73.online -uroot -pRoboShop@1 < /app/schema/shipping.sql  &>>/tmp/roboshop.log

echo -e "\e[33m start shipping service \e[0m"
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping