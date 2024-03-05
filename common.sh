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