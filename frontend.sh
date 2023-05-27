# roboshop nginx script
echo -e "\e[33minstalling nginx server\e[0m"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "\e[33mRemoving old app content\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e[33mDownloading frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log 2>/tmp/error.log

echo -e "\e[33mExtract frontend content\e[0m"
cd /usr/share/nginx/html &>>/tmp/roboshop.log
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

cho -e "\e[33m Nginx Reverse Proxy Configuration \e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[33mStarting nginx server\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log