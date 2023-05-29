source common.sh
component=payment
app_path="/app"


echo -e "${color} Install Python${nocolor}"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "${color} Add Application User ${nocolor}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color} Create Application Directory${nocolor}"
rm -rf $app_path &>>/tmp/roboshop.log
mkdir $app_path

echo -e "${color} Download Application Content ${nocolor}"
curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd $app_path

echo -e "${color} Extract Application Content ${nocolor}"
unzip /tmp/$component.zip &>>/tmp/roboshop.log

echo -e "${color} Install Application Dependencies ${nocolor}"
cd $app_path
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -e "${color} Setup SystemD File ${nocolor}"
cp /home/centos/Roboshop-Project/$component.service /etc/systemd/system/$component.service   &>>/tmp/roboshop.log

echo -e "${color} Start Payment Serrvice ${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable $component  &>>/tmp/roboshop.log
systemctl restart $component &>>/tmp/roboshop.log
