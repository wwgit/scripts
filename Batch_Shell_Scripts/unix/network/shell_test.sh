#!/bin/bash
#import ./timeUtil.sh; It can be written in another way like '. ./timeUtil.sh'
source ./timeUtil.sh

today=`date +%y%m%d`;
echo "today is "$today;
cur_path=`pwd`;
ret_folder="result";
ret_path=$cur_path/$ret_folder/$today;

#some guidance stuffs here !
usage(){

  if  [ X = "$1"X ]; then
  
     echo "here is manual of how to use this script:";
	 echo "for netutil.sh, the first parameter must be: -netstat, -ip, -ftp !"
	 echo "e.g netutil.sh -netstat \"detailed commands here\";"
	 exit 1;
	 
  elif [ "-netstat"X = "$1"X ]; then 
  
     echo "for -netstat, basically it has two mode to be run,
	       detailed command could be like following:"
     echo "'m=b' means basic mode used, and it will use execute command netstat -apn"
	 echo "Last opt t/u is decided by tp: eg tp=t,cond=listen"
	 echo "if m=a, option int and dur will be ignored !"
	 echo "it supports multi-conditions filtering the command output"
	 echo "cond=tcp-3306-TIME_WAIT,cond=udp-80,cond=..."
	 echo "each value of cond will be used as filters for one query"
	 echo "each cond represents one separate query, which does Not has relation to 
	       other queries, and you can check several different queries using different
		   filters by just running this script one time !"
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
	 exit 1;
	 
  elif [ "-ip"X = "$1"X ]; then	 
	      echo "for -ip, basically it has two mode to be run,
	       detailed command could be like following:"
  fi
  
}

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

  local condArr=$2;
  local cmd=$1;
  local cmdOutput=;
  
  #it will have problem if all commands are in one variable(suppose we have many conds),
  #so we have to use a variable to save result and pass to the following commands
  #It first run netstat -apnt, and pass the result to cmdOutput,
  #Then pass results to do greping with conds array for further filtering
  #Finally, it will get the final result of condition filtering.	
  cmdOutput=`$cmd`;
  
  for item in ${condArr[@]}
  do  
      cmdOutput=`echo "${cmdOutput}"|grep -i ${item}`;	  
  done
  
  #Here double quota is used to keep format as it was!
  echo "$cmdOutput";

}

#It handles netstat commands by multi conditions and offers different modes
#input1: array of filtering conditions
#output: for basic mode, it outputs final result is output of netstat running
#        for advance mode, it outputs total counts for same tcp connection status,
#        based on given multi-conditions and save result into files
netstExec(){

  local condArr=$1;  
  local mode="a";local tp="t";local filename="ns"; 
  local query_conds=();local ns_cmd="netstat";
  local int=20;local dur="30m";
  local colName="";local colValue=""; 
  local cmdOutput="";local i=0;  
  local time_begin="";
  local act_dur=0;  local rest_durs=0;
  local outTofile="";
  
  for item in ${condArr[@]}
   do
	  colName=${item%=*};colValue=${item#*=};
	  
	  case $colName in 
			 m)    mode=$colValue;;
			 cond) 
				 query_conds[$i]=$colValue;			 
				 let i+=1;;
			 int)  int=$colValue;;
			 dur)  dur=$colValue;;		 
			 *)
			   echo "second parameter format not correct";
			   usage "-netstat";;
	   esac
	  
   done
   
   local sub_conds=;
   
   if [ "$mode"X = "b"X ]; then
   
      ns_cmd="$ns_cmd"" -apn";
	  filename=${filename}_basic;
	  
	  for item_b in ${query_conds[*]}
	  do
	      #handling sub-conditions here
		  sub_conds=(`splitFun $item_b "-"`);
		  cmdOutput=`cmdExec "$ns_cmd" "${sub_conds[*]}"`;		  
		  echo "$cmdOutput">$ret_path/${filename}_${sub_conds[0]}_${sub_conds[1]}`date "+%H%M%S"`.txt
	  done
	  
   fi
   
   if [ "$mode"X = "a"X ]; then
       
	   time_begin=`date "+%H%M%S"`;
	   
       ns_cmd="$ns_cmd"" -apnt";	   
	   filename=${filename}_advance;
	   dur=`converToSec $dur`;
	   rest_durs=$dur;
	     
	   while [ $rest_durs -ge 0 ]
       do

	       for item_b in ${query_conds[*]}
			do
			    #handling sub-conditions here
			    sub_conds=(`splitFun $item_b "-"`);
			    cmdOutput=`cmdExec "$ns_cmd" "${sub_conds[*]}"`;
			    
			    #It only cares the connection status count(which is the 6th column in command result)
			    #command result of 'netstat -apnt'
			    cmdOutput=`echo "$cmdOutput" | awk '{++state[$6]}
			    END{for(i in state) print state[i]}'`;	
			    
                #fileName format handling happens here:
                cmdOutput="totalNum="$cmdOutput","${sub_conds[0]}","${sub_conds[1]}","`date "+%H:%M:%S"`;					
			    echo "$cmdOutput">>$ret_path/${filename}_${sub_conds[0]}_${sub_conds[1]}_${time_begin}.txt
		    done
		  
		  sleep $int;
		  act_dur=$((act_dur+=$int));
		  rest_durs=$(($dur-$act_dur));
          echo "rest time is: "$rest_durs;		  		  
       done	   	   
	   
   fi

}

#It handles ip commands multi conditions and offers different modes
ipExec(){

  
  echo "hello ip";
  
}

#It handles different network commands and choose different engine to execute commands
#input1: user's first input parameter - to choose one network to use
#input2: user's second input parameter in which multi-conditions and options are included
optParse(){

   local str=$2;local conds=;
  
   #retrieve condition array from awk
   conds=(`splitFun "$str" ","`);
   
   case $1 in
   
      -netstat)
	     netstExec "${conds[*]}";;
	  -ip)
	     ipExec "${conds[*]}";;
   
   esac
        
}

#main entrance:
main_loop(){

  if [ X = "$1"X ]; then
	     usage;
  fi
  if [ X = "$2"X ]; then
	     usage $1;
  fi
  
  if [ ! -d "$ret_path" ]; then
      mkdir -p $ret_path;
  fi
    
  optParse $1 $2;

}

main_loop $1 $2