print_task_heading() {
  echo $1
  echo "########## $1 ###########" &>>/tmp/expense.log
}

check_status(){
if [ $1 -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi
}