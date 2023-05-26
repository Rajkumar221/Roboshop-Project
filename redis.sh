"\e[33m installing redis repo file \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log

"\e[33m enabling  redis 6.2 \e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log

"\e[33m installing redis \e[0m"
yum install redis -y &>>/tmp/roboshop.log
  
"\e[33m Update listen address\e[0m"
sed -i 127.0.0.1 0.0.0.0 /etc/redis.conf /etc/redis/redis.conf &>>/tmp/roboshop.log

"\e[33m start redis service\e[0m"
systemctl enable redis  &>>/tmp/roboshop.log
systemctl start redis 