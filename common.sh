LOG=/tmp/expense.log
print_task_heading() {
  echo $1
  echo "########## $1 ###########" &>>$LOG
}

check_status(){
if [ $1 -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit 2
fi
}

Pre_req_app(){
print_task_heading "clean the old content"
rm -rf ${app_dir} &>>$LOG
check_status $?

print_task_heading "create app directory"
mkdir ${app_dir} &>>$LOG
check_status $?

print_task_heading "download app content"
curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$LOG
check_status $?

print_task_heading "extract app content"
cd ${app_dir} &>>$LOG
unzip /tmp/${component} &>>$LOG
check_status $?
}