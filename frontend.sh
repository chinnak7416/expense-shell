source common.sh
app_dir=/usr/share/nginx/html
component=frontend
print_task_heading "Install nginx"
dnf install nginx -y &>>$LOG
check_status $?

print_task_heading "Start nginx"
systemctl enable nginx &>>$LOG
systemctl start nginx &>>$LOG
check_status $?

print_task_heading "Copy expense nginx configuration"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
check_status $?

Pre_req_app

print_task_heading "Start nginx service"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
check_status $?