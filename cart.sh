echo -e "\e[33m Setup NodeJS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/roboshop.log

echo -e "\e[33m install nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m add cart and app directory\e[0m"
useradd roboshop &>>/tmp/roboshop.log
rm -rf /app
mkdir /app 

echo -e "\e[33m download the app content \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip  &>>/tmp/roboshop.log
cd /app 
unzip /tmp/cart.zip &>>/tmp/roboshop.log

echo -e "\e[33m download the dependencies\e[0m"
cd /app  &>>/tmp/roboshop.log
npm install  &>>/tmp/roboshop.log
 
echo -e "\e[33m setup systemd service\e[0m"
cp cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log

echo -e "\e[33m start cart service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart 
systemctl start cart
