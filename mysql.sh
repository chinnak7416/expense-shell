source common.sh
mysql_root_password=$1
#If password is not provide then exit
if [ -z "${mysql_root_password}" ]; then
  echo Input password is missing.
  exit 1
fi
print_task_heading "Install mysql-server"
dnf install mysql-server -y &>>$LOG
check_status $?

print_task_heading "Enable mysqld"
systemctl enable mysqld &>>$LOG
check_status $?

print_task_heading "Start mysqld"
systemctl start mysqld &>>$LOG
check_status $?

print_task_heading "Set up mysql password"
echo 'show databases' |mysql -h 172.31.46.141 -uroot -p${mysql_root_password} &>>$LOG
if [ $? -ne 0 ]; then
  mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOG
fi
check_status $?
