#!/bin/bash
#import ./timeUtil.sh; It can be written in another way like '. ./timeUtil.sh'
source $MYSHELL_ROOT/misc/timeUtil.sh
source $MYSHELL_ROOT/misc/strUtil.sh

today=`date +%y%m%d`
mytime=`date +%H%M%S`
ret_folder="result"
log_folder="logs"
ret_path=$MYSHELL_ROOT/$ret_folder/$today
log_path=$MYSHELL_ROOT/$log_folder/$today

fileName=${0##*/}
namePart=${fileName%.*}

fdRec=$log_path/${namePart}_fdRecord_${mytime}.log
stdErr=$log_path/${namePart}_Err_${mytime}.log
stdInOut=$log_path/${namePart}_inout_${mytime}.txt

#some guidance stuffs here !
usage(){

  if  [ X = "$1"X ]; then
  
     echo "here is manual of how to use this script:"
	 echo "for netutil.sh, the first parameter must be: -netstat, -ip, -ftp !"
	 echo "e.g netutil.sh -netstat \"detailed commands here\";"
	 exit 1
	 
  elif [ "-netstat"X = "$1"X ]; then 
  
     echo "for -netstat, basically it has two mode to be run,
	       detailed command could be like following:"
     echo "'m=b' means basic mode used, and it will use execute command netstat -apn"
	 echo "if m=a, option int and dur will be ignored !"
	 echo "it supports multi-conditions filtering the command output"
	 echo "cond=80,cond=192.168.1.1,cond=..."
	 echo "related result is: netstat -apn| grep 80 | grep 192.168.1.1 | grep.."
	 echo "**********************************************************************"
	 echo "'m=a' means advance mode used,it will execute command in a given period 
	       with specified interval"
	 echo "you can set your interval by adding int=30 into second parameter string,
	       and unit is second."
	 echo "you may set your duration by adding dur=30m into second parameter string as well,
	       and last character must be s,m or h; h is hour,m is minute and s is second."
	 echo  "result will be saved in result folder !"
	 echo  "*************************************************************************"
	 echo "default values if some option is not provided in second parameter:"
	 echo "int=20"
	 echo "dur=30m"
	 echo "***************************************************************************"
	 echo "it supports multi-conditions filtering the command output 
	       by adding cond=cond1,cond=cond2,... etc"
	 echo "cond handling is just as same as basic mode !"
	 echo "for cs option, it sets the connection status you want to check: "
	 echo "e.g cs=listen or cs=LISTEN; it's case insensitive"
	 echo "Important ! cs option can only be added once !"
	 exit 1
	 
  elif [ "-ip"X = "$1"X ]; then	 
	      echo "for -ip, basically it has two mode to be run,
	       detailed command could be like following:"
		   exit 1
  fi
  
}


err_quit(){

   test ""X != "${1}"X || echo "some error happened !" >>$stdErr
    
   echo $1 >>$stdErr
   
   exit 1

}


stdRecov(){
  
  #recover stdin and stdout
  exec 1>&888
  
  # close the fd
  exec 888>&-

}

stdRedirec(){

  local highFd=
  
  highFd=`ulimit -n <>$stdInOut 2>>$stdErr`
  
  #
  highFd=`ls /proc/self/fd/ | awk -v fd="$highFd" '{ i=0;
									  for(j=1;j<=NF;j++){
									     if(888 == i)
										     break;
										 i=$j;										     
									  }								  
								  }END{
										if(i<fd)                            
										   print i;
										else
										   print 0;
								  }'`
  echo "new Fd is " $highFd
  
  test $highFd -lt 888 || err_quit "fd 888 has been occupied !"
  
  #bind new Fd to stdOut
  exec 888>&1 2>>$stdErr

  #bind stdIn out to file  
  exec 1<>$stdInOut 2>>$stdErr

}

#It generates a proper string using given original string and str need to be appended
#input1: original string 
#input2: string that need to be added to original string
#input3: delimit that separate string
#output: new string
strAppend(){

  local str=
  
  test ""X == "${2}"X || str=${1}${3}${2}
  
  echo "$str" <>$stdInOut 2>>$stdErr

}

#This function is retired. Please use ./misc/strUtil.sh::splitStrNewFormat
#It reads from a string and split it into array using given separator
#input1: string to be split
#input2: separator
#output: an array retrieved from output of awk program
splitFun(){

  local array=;
  array=`echo "$1"|awk -F $2 'END{for(i=1;i<=NF;i++){print $i}}'`;
  
  #Not to use double quota for format concern,directly output value can 
  #ajust its format into something like 'm=a cond=listen int=30 dur=30m',
  #instead of the following format which we don't want:
  #m=a
  #cond=listen
  #int=30
  #dur=30m
  echo $array;

}

#It receives a result of one command and continues to filter the result by given conditions
#input1: a one command - not recommended to use pipe
#input2: a array in which multi-conditions has been saved
cmdExec(){

  local condArr=$2
  local cmd=$1
  local cmdOutput=
  
  #it will have problem if all commands are in one variable(suppose we have many conds),
  #so we have to use a variable to save result and pass to the following commands
  #It first run netstat -apnt, and pass the result to cmdOutput,
  #Then pass results to do greping with conds array for further filtering
  #Finally, it will get the final result of condition filtering.	
  cmdOutput=`$cmd <>$stdInOut 2>>$stdErr` 
  
  #echo "rough result of netstat -apnt is "
  #echo "$cmdOutput"
  
  for item in ${condArr[@]}
  do  
      cmdOutput=`echo "${cmdOutput}"|grep -i ${item} `   
      #echo "after filtered by ${item}, result of netstat is:"
      #echo "$cmdOutput"	  
  done
  
  #Here double quota is used to keep format as it was!<>$stdInOut 2>>$stdErr
  echo "$cmdOutput" >$stdInOut 2>>$stdErr 

}

#It handles netstat commands by multi conditions and offers different modes
#input1: array of filtering conditions
#output: for basic mode, it outputs final result is output of netstat running
#        for advance mode, it outputs total counts for same tcp connection status,
#        based on given multi-conditions and save result into files
netstExec(){

  local condArr=$1 
  local mode="a"; local filename="ns" 
  local query_conds=(); local ns_cmd="netstat"
  local int=20; local dur="30m"
  local colName=""; local colValue="" 
  local cmdOutput=""; local i=0  
  local time_begin=""
  local act_dur=0; local rest_durs=0
  local conn_stats=
  
  for item in ${condArr[*]}
   do
	  colName=${item%=*};colValue=${item#*=}
	  
	  case $colName in 
			 m)  mode=$colValue;;
			 cond) 
				 query_conds[$i]=$colValue			 
				 i=$((i+=1));;
			 int) int=$colValue;;
			 dur) dur=$colValue;;
             cs) conn_stats=$colValue
			     query_conds[$i]=$colValue; i=$((i+=1));;		 
			 *)
			   echo "second parameter format not correct" >>$stdErr
			   usage "-netstat";;
	   esac
	  
   done 
   
   time_begin=`date "+%H%M%S" <>$stdInOut 2>>$stdErr`
   
   if [ "$mode"X = "b"X ]; then
   
      ns_cmd="$ns_cmd"" -apn"	  
	  cmdOutput=`cmdExec "$ns_cmd" "${query_conds[*]}" <>$stdInOut 2>>$stdErr`
	  
	  filename=${filename}_basic
	  ret_path=$ret_path/${filename}
	  ret_path=`strAppend $ret_path ${query_conds[0]} "_" <>$stdInOut 2>>$stdErr`		   
	  ret_path=`strAppend $ret_path ${conn_stats} "_" <>$stdInOut 2>>$stdErr`          
	  ret_path=${ret_path}_${time_begin}.txt
	  
	  test ""X != "$cmdOutput"X || cmdOutput='no result found !' <>$stdInOut >>$stdErr
	  
	  echo "$cmdOutput">$ret_path 2>>$stdErr
	  
   fi
   
   if [ "$mode"X = "a"X ]; then	   
	   
       ns_cmd="$ns_cmd"" -apnt"	
	      
	   #fileName format handling happens here:<>$stdInOut 2>>$stdErr
	   filename=${filename}_advance
	   ret_path=$ret_path/${filename}
	   ret_path=`strAppend $ret_path ${query_conds[0]} "_" <>$stdInOut 2>>$stdErr`		   
	   ret_path=`strAppend $ret_path ${conn_stats} "_" <>$stdInOut 2>>$stdErr`          
	   ret_path=${ret_path}_${time_begin}.txt
	   
	   #call function outside this shell - need to ajust stdin stdout
	   #otherwise, there may be some issues when running in back end
	   stdRedirec
	   dur=`converToSec $dur`
	   #need to change stdin stdout back once outside call is done.
	   stdRecov
	  
	   rest_durs=$dur
	   #echo $rest_durs
	     
	   while [ $rest_durs -gt 0 ]
       do
           cmdOutput=`cmdExec "$ns_cmd" "${query_conds[*]}" <>$stdInOut 2>>$stdErr`
		   
		   echo "netstat result now is: "
		   echo "${cmdOutput}"
		   
		   echo "contents in stdinout file:"
		   cat $stdInOut
		   
		   #It only cares the connection status count(which is the 6th column in command result)
		   #command result of 'netstat -apnt'
		   cmdOutput=`echo "$cmdOutput" | awk -v conn_status="$conn_stats" 'BEGIN{
                                                 IGNORECASE=1;
												 state[conn_status]=0; 
												 } {
												     if( $6 == conn_status ) 
											         {++state[conn_status];}
												   }
			                                    END{ print state[conn_status]; }' <>$stdInOut 2>>$stdErr`
											   
		   #fileName contents handling happens here:
           cmdOutput="totalNum="${cmdOutput}
		   cmdOutput=`strAppend $cmdOutput ${query_conds[0]} "," <>$stdInOut 2>>$stdErr`
		   cmdOutput=`strAppend $cmdOutput ${conn_stats} "," <>$stdInOut 2>>$stdErr`
		   cmdOutput=${cmdOutput}","`date "+%H:%M:%S" <>$stdInOut 2>>$stdErr`
          		   	   
		   echo "$cmdOutput">>$ret_path
		  
		   sleep $int
		   act_dur=$((act_dur+=$int))
		   rest_durs=$(($dur-$act_dur))
           echo "rest time is: "$rest_durs	  		  
       done	   	   
	   
   fi

}

#It handles ip commands multi conditions and offers different modes
ipExec(){

  
  echo "hello ip";
  
}

#It handles different network commands and choose different engine to execute commands
#input1: user's first input parameter - to choose one network command to use
#input2: user's second input parameter in which multi-conditions and options are included
optParse(){

   local str=$2; local conds=
  
   #retrieve condition array from awk
   #call function outside this shell - need to ajust stdin stdout
   #otherwise, there may be some issues when running in back end
   stdRedirec
   conds=(`splitStrNewFormat "$str" ","`)
   #need to change stdin stdout back once outside call is done.
   stdRecov
   
   case $1 in
   
      -netstat)
	     netstExec "${conds[*]}";;
	  -ip)
	     ipExec "${conds[*]}";;
   
   esac
        
}

#main entrance:
main_loop(){

  if [ $# -eq 0 ]; then
	     usage;
  fi
  if [ $# -eq 1 ]; then
	     usage $1;
  fi
  
  mkdir -p $ret_path 
  mkdir -p $log_path 
    
  optParse $@

}


#stdRedirec

main_loop $@

#stdRecov