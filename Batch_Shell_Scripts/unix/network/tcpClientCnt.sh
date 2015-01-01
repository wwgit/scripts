#!/bin/bash
source $MYSHELL_ROOT/misc/strUtil.sh
source $MYSHELL_ROOT/misc/timeUtil.sh
#source $MYSHELL_ROOT/network/netUtil.sh

today=`date +%y%m%d`
mytime=`date +%H%M%S`
#echo "today is "$today;
file_name=${0##*/}
ret_folder="result"
log_folder="logs"
ret_path=$MYSHELL_ROOT/$ret_folder/$today
log_path=$MYSHELL_ROOT/$log_folder/$today


mkdir -p $log_path
echo $file_name

error_quit(){

   test ""X != "${1}"X || echo "some error happened !" \
   2>>$log_path/${file_name}_errors.log
   
   echo $1 \
   2>>$log_path/${file_name}_errors.log
   
   exit 1
   
}

inputParNumChk(){
  
  if [ $# -eq 0 ]; then
      error_quit "Error! No input parameters!"
  fi

}

# $@ means all input each separate parameter is in quotas - eg "p1" "p2" "p3"
# $# means all input parameters are in one quota - eg "p1 p2 p3"
inputParNumChk $@

#default value
int=20
dur=30m
options=
conds=
conn_status=

#main entrance is here
main_loop(){

    local colName=; local colValue=
	local condStr=
	local cmdStr=
	options=(`splitStrNewFormat "$*" " "  `) 
    #2>>${log_path}/${mytime}_errors.log	

	for i in ${options[@]}
	do
	   colName=${i%=*};colValue=${i#*=}
	   #conds=(`splitStrNewFormat $@ ","`);
	   
	   [ ""X = "${colValue}"X ] && error_quit "Error! value cannot be null!"
	   
	   case $colName in 
	       int) int=$colValue;;
		   dur) dur=$colValue;;
		   cond)
                test ""X != "${condStr}"X && condStr=${condStr}","		   
				condStr=${condStr}"cond="$colValue;;
		   cs) 
		        test ""X != "${condStr}"X && condStr=${condStr}","
		        conn_status=$colValue 
				condStr=${condStr}"cond="${conn_status};;			
		        
	   esac	   

	done
	
	local cmdStr="m=a,int=$int,dur=$dur"
	
    if test ""X != "${conn_status}"X; then
	
	   cmdStr=${cmdStr}","${condStr}",ts=TIME_WAIT"
	   sh $MYSHELL_ROOT/network/netUtil.sh -netstat $cmdStr &
	   
	   cmdStr=${cmdStr}","${condStr}",ts=ESTABLISHED"
	   sh $MYSHELL_ROOT/network/netUtil.sh -netstat $cmdStr &
	
	else
	
	  cmdStr=${cmdStr}","${condStr}
	  sh $MYSHELL_ROOT/network/netUtil.sh -netstat $cmdStr &

    fi      
		
}

main_loop $@