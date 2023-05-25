#Mongodb setup

echo -e "\e[33mCopy mongodb repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e "\e[33minstall mongodb server\e[0m"
yum install mongodb-org -y 

## Modify the config file 

echo -e "\e[33mstart mongodb service\e[0m"
systemctl enable mongod 
systemctl restart mongod 
