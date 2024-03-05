source common.sh

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

print_task_heading "Remove old content"
rm -rf /usr/share/nginx/html/* &>>$LOG
check_status $?

print_task_heading "Download App content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>$LOG
check_status $?

print_task_heading "Extract app content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$LOG
check_status $?

print_task_heading "Start nginx service"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
check_status $?