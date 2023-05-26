echo -e "\e[33mConfigure YUM Repos\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[33mConfigure YUM Repos for RabbitMQ.\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[33m install rabbitmq\e[0m"
yum install rabbitmq-server -y  &>>/tmp/roboshop.log

echo -e "\e[33mstart rabbitmq seerver\e[0m"
systemctl enable rabbitmq-server  &>>/tmp/roboshop.log
systemctl start rabbitmq-server 

echo -e "\e[33m create user \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

