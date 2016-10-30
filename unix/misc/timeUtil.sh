#!/bin/bash

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

#for Debug use:
#do 'export DEBUG=true' before use it
DEBUG(){

  if [ "$DEBUG"X = "true"X ]; then
        $@;
  fi

}

#convert to second if needed as per the last character of time unit
#input1: string like 10m or 10h or 10s
#output2: numeric number of seconds
converToSec(){
   #to open debug mode
   #set -X
   
   local exp_durs=; local unit=;
   exp_durs="$1"; 
   
   unit=`echo $exp_durs|sed -n "s/^[0-9]\+//p"`;

   exp_durs=`echo $exp_durs|sed -n "s/[hms]$//p"`;
   
   case ${unit} in  
     s) ;;
	 m) exp_durs=$((exp_durs*=60));;
	 h) exp_durs=$((exp_durs*=120));;    
   esac
 
   echo $exp_durs 
   
   #to close debug mode
   #set +X
}

#do Not recommend to use this function
clockChk(){
  
  local exp_durs=;
  local act_durs=;
  local rest_durs=;
  
  local unit=;
  act_durs="$1"; exp_durs="$2"; 
   
  unit=`echo $exp_durs|sed -n "s/^[0-9]\+//p"`;
  #echo "unit is "$unit;
  exp_durs="$2";
  exp_durs=`echo $exp_durs|sed -n "s/[hms]$//p"`;
  
  case ${unit} in
     s) ;;
	 m) exp_durs=$((exp_durs*=60));;
	 h) exp_durs=$((exp_durs*=120));; 
  esac
  
  if [ $act_durs -ge $exp_durs ]; then 
        echo 0;
  else
       rest_durs=$(($exp_durs-$act_durs));
       echo $rest_durs;	   
  fi

}


# calculate the time of ending using given expected duration
#input1: begin time - now in format like: dd:hh:mm:ss
#input2: string of expected duration in format like 10s,20m,or 23h
#output: end time in format like dd:hh:mm:ss
endTimeCalculate(){
 
  #date "+%Z";
  local hr=;local min=;local sec=;
  local tmp=();local durs=;
  
  local hr_e=;local min_e=;local sec=;
  local time_end=;local day_e=0;
  
  #retrieve array data from awk output
  eval `echo "$1" | awk -F ":" '
        END{for(i=1;i<=NF;i++){print "tmp["i"]="$i} }'
  `;
  #echo "${tmp[1]}";
  hr=${tmp[1]};
  min=${tmp[2]};
  sec=${tmp[3]};
  echo hr is ${hr};echo min is $min;echo min is "$sec";
  
  durs="$2";
  echo dur is "$dur";
  case ${durs:2} in
      s)
	   durs=${durs:0:2};
	   hr_e=$hr;
	   min_e=$min;
	   let sec_e="$sec+$durs";
	   if [ $sec_e -ge 60 ]; then 
	      let "sec_e-=60";
		  let "min_e+=1";
		  if [ $min_e -ge 60 ]; then
		     let "min_e-=60";
			 let "hr_e+=1";         			 
		  fi 
	   fi
	   echo $durs;;
      m)
	   durs=${durs:0:2};
	   sec_e=$sec;
	   hr_e=$hr;
	   let min_e="$min+$durs";
	   if [ $min_e -ge 60 ]; then
	      let "min_e-=60";
		  let "hr_e+=1";	      
	   fi
	   echo $durs;;
	  h)
	   durs=${durs:0:2};
	   sec_e=$sec;
	   min_e=$min;
	   let hr_e="$hr+$durs";
	   if [ $hr_e -ge 24 ]; then
	      	 let "hr_e=$hr_e%24";
			 let "day_e=$durs/24";
	   fi
	   echo $durs;;
  esac
  
  #let min_e=
  time_end=$day_e":"$hr_e":"$min_e":"$sec_e;
  echo "$time_end";
  
}