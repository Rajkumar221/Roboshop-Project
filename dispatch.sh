echo -e "\e[33m install golang\e[0m" 
yum install golang -y &>>/tmp/roboshop.log
 
echo -e "\e[33m add user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m setup app  file \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m download app content \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip  &>>/tmp/roboshop.log
cd /app 
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log

echo -e "\e[33m download the dependensis \e[0m"
cd /app 
go mod init dispatch &>>/tmp/roboshop.log
go get  &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log
 
echo -e "\e[33m setup systemd service \e[0m"
cp /home/centos/Roboshop_project/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[33m reload \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[33m stasrt dispatch service\e[0m"
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl start dispatch &>>/tmp/roboshop.log