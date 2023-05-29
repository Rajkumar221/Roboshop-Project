source common.sh
component=catalogue


nodejs

echo -e "${color} Install mongodb shell ${nocolor}"
cp mongodb.repo etc/yum.repos.d/mongodg.repo &>>$log_file
yum install mongodb-org-shell -y &>>$log_file

echo -e "${color} Load Schema ${nocolor}"
mongo --host mongodb-dev.devops73.online <${app_path}/schema/$component.js &>>$log_file