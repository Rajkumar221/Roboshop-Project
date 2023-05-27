echo -e "\e[33m install python \e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[33m add user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m make app directory \e[0m"
rm -rf /app
mkdir /app &>>/tmp/roboshop.log
 
echo -e "\e[33m download the app content \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip  &>>/tmp/roboshop.log
cd /app 
unzip /tmp/payment.zip &>>/tmp/roboshop.log

echo -e "\e[33m install dependencies \e[0m"
cd /app  &>>/tmp/roboshop.log
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -e "\e[33m setup systemd service \e[0m"
cp payment.service /etc/systemd/system/payment.service

echo -e "\e[33m reload \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[33m start payment service \e[0m"
systemctl enable payment
systemctl restart payment