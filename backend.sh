source common.sh
app_dir=/app
component=backend
mysql_root_password=$1
#If password is not provide then exit
if [ -z "${mysql_root_password}" ]; then
  echo Input password is missing.
  exit 1
fi
print_task_heading "disable default nodejs version"
dnf module disable nodejs -y &>>$LOG
check_status $?


print_task_heading "enable nodejs version:20"
dnf module enable nodejs:20 -y &>>$LOG
check_status $?

print_task_heading "install nodejs"
dnf install nodejs -y &>>$LOG
check_status $?

print_task_heading "adding application user"
id expense &>>$LOG
if [ $? -ne 0 ]; then
  useradd expense &>>$LOG
fi
check_status $?

print_task_heading "copy backend service file"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
check_status $?

Pre_req_app

print_task_heading "download nodjs dependencies"
cd /app &>>$LOG
npm install &>>$LOG
check_status $?

print_task_heading "reload the service"
systemctl daemon-reload &>>$LOG
check_status $?

print_task_heading "start backend service"
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
check_status $?

print_task_heading "install mysql client"
dnf install mysql -y &>>$LOG
check_status $?

print_task_heading "load schema"
mysql -h mysql-dev.ramdevops78.online -uroot -p${mysql_root_password} < /app/schema/backend.sql  &>>$LOG
check_status $?

print_task_heading ""restart bckend""
systemctl restart backend &>>$LOG
check_status $?

