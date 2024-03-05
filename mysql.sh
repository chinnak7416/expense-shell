source common.sh

print_task_heading "Install mysql-server"
dnf install mysql-server -y &>>$LOG
check_status $?

print_task_heading "Enable mysqld"
systemctl enable mysqld &>>$LOG
check_status $?

print_task_heading "Start mysqld"
systemctl start mysqld &>>$LOG
check_status $?

print_task_heading "Set root password"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG
check_status $?