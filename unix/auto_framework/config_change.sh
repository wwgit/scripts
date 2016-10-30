#!/bin/bash

#default configurations
root_path='/home/tomcat/lpt10'
web_conf_xml='conf/server.xml'
jmx_conf_file='run.sh'
confFiles=('config.properties' 'globals.properties' 'mq.properties' 'jdbc.properties')
conf_root_path='/data/app_resource'
filePathArr=

#var for regular expression
ip_reg='\([0-9]\{1,3\}\.\?\)\{4\}'
port_reg='[0-9]\{4,5\}'
redis_head='\(^redis\.sentinels=\|^redis\.serverPath=\)'
redis_reg=''$redis_head'\('$ip_reg':'$port_reg',\?\)*'

#default value need to be updated
ip='1.1.1.150'

#redis
redis_masters='mymaster'
redisurl='1.1.1.31:26379,1.1.1.32:26379'
redis_pwd='howbuy'
#redisConfFiles=( 'config.properties'  'globals.properties' )
#oracle
oracle_url='jdbc:oracle:thin:@1.1.1.11:1521:hbqa'
#oracleConfFiles=('config.properties' 'jdbc.properties')
user_header='LPT4'
or_password='howbuy_qa_qwerVBNM'
#mq
#mqConfFiles=('config.properties' 'mq.properties' 'globals.properties')
mq_url='tcp:\/\/1.1.1.31:61616'
mq_user='admin'
mq_password='admin'
#dubbo
dubbo_url='zookeeper:\/\/1.1.1.31:2181'
#dubboConfFiles=('config.properties' 'globals.properties')


#help file
selfHelp() {
	
	echo 'This is self help for config_change.sh !'
	echo 'Details of how options work: '
	echo "option '-help': print help manual for user. Example: config_change.sh -help"
	echo "option '-uniform': This is for updating all files using same configuration."
	echo ""

}

#param1 is orgin string; param2 is separator to cut the string
strSplit() {

  local array=;
  array=`echo "$1"|awk -F $2 'END{for(i=1;i<=NF;i++){print $i}}'`;
  echo $array

}


#tomcat ports in server.xml; http port; shutdown port; ajp port
tomcatPortsUpdate() {

  #update /APP_HOME/conf/server.xml - http port; shutdown port; ajp port
  echo 'updating web port: ' "$root_path/$1/$web_conf_xml"
  sed -i -e 's/port=\"'$port_reg'\" protocol=\"HTTP\/1\.1\"/port=\"'$2'\" protocol=\"HTTP\/1\.1\"/;tx;ba' \
  -e ':a;s/port=\"'$port_reg'\"\( shutdown=\"SHUTDOWN\"\)/port=\"'$3'\"\1/;tx;bc' \
  -e ':c;s/port=\"'$port_reg'\"\( protocol=\"AJP.*\"\)/port=\"'$4'\"\1/;:x' \
  "$root_path/$1/$web_conf_xml" 
  
}

#update jmx config - param1 is app Name; param2 is jmx server ip and port
jmxUpdate() {

  #update /APP_HOME/bin/run.sh - jmx port
  echo 'updating jmx port: ' "$root_path/$1/$jmx_conf_file"
  sed -i 's/jmxremote.port='$port_reg'/jmxremote.port='$2'/g' \
  "$root_path/$1/$jmx_conf_file"
  
  #update /APP_HOME/bin/run.sh - ip address
  echo 'updating rmi server ip address: ' "$root_path/$1/$jmx_conf_file"
  sed -i 's/^\(-Djava.rmi.server.hostname\)='$ip_reg'/\1='$ip'/g' \
  "$root_path/$1/$jmx_conf_file"

}

#update redis config - param1 is app config path;
# 					   param2 is redis address/addresses; param3 is password if has
#/'$redis_head'/ba;        - if redis head found, goto label a;
#s/'$redis_reg'/\1'$2'/	   - if found, replace with param1 by executing s/'$redis_reg'/\1'$2'/
# n;                       - go to next line to see if it is redis password config
#/\(^redis\.password=\)/bc;  if next line is password config, go to label c;
#:c;s/\(^redis\.password=\).*/\1'$3'/
#						   - replace with password
#:d;/^redis\..*=/i\redis\.password='$3'
#						   - if password config is not next to redis head,
#							 execute label d to insert one line for redis.password=$password
#:e;/[^r][^e][^d][^i][^s]\..*/bx;:j;/^redis\.password=/d;
#						   - at last, we need to check:
#							 - if password config is set in other below lines in redis config section
#							 - delete it if it exist in other place in redis section
#
redisUpdate() {

#    local tmp=; local flag=
			
	if [ ""X != "$1"X ]
	then
	   echo 'updating redis for file '$1'...'
	   sed -i -e '/'$redis_head'/ba;be;:a;s/'$redis_reg'/\1'$2'/;n;' \
	   -e '/\(^redis\.password=\)/bc;:d;/^redis\..*=/i\redis\.password='$3'' \
	   -e 'tf' \
	   -e ':c;s/\(^redis\.password=\).*/\1'$3'/' \
	   -e ':f;n;:e;/[^r][^e][^d][^i][^s]\..*/bx;:j;/^redis\.password=/d;:x' \
	   $1
	   sed -i 's/\(^redis\.masters\)=.*/\1='$4'/' $1
	else
	   echo 'error for updating redis... config path is null'
	fi

}


#update db config - param1 is app config path;
#				  - param2 is db url; param3 is db_username_header; param4 is db_password
oracleUpdate() {

#	local tmp2=; local flag=

	if [ ""X != "$1"X ]
	then
		echo 'updating oracle for file '$1'...'
		sed -i -e '/^\([a-zA-Z]\+\.\?\)*=oracle\.jdbc\.driver\.OracleDriver/ba;bx' \
		-e ':a;n;s/^\(\([a-zA-Z]\+\.\?\)*\)=jdbc:oracle:.*/\1='$2'/;tc;bx' \
		-e ':c;n;s/^\(\([a-zA-Z]\+\.\?\)*user.*\)=.*\(_.*128_.*\)$/\1='$3'\3/;te;bx' \
		-e ':e;n;s/^\(\([a-zA-Z]\+\.\?\)*password\)=.*/\1='$4'/' \
		-e ':x' \
		$1
	else
	   echo 'error for updating oracle... config path is null'
	fi		


}

#update mq config - param1 is app config path;
#					param2 is mq url; param3 is mq username; param4 is mq password
mqUpdate() {

#	local tmp3=; local flag=

	if [ ""X != "$1"X ]
	then
		echo 'updating mq for file '$1'...'
		
		sed -i -e ':a;/^mq\..*/bo;bx' \
		-e ':o;s/^\(mq\.brokerURL\)=.*/\1='$2'/;te;bn' \
		-e ':e;n;s/^\(mq\.userName\)=.*/\1='$3'/;tc;bf' \
		-e ':c;n;:h;s/^\(mq\.password\)=.*/\1='$4'/;tm;bj' \
		-e ':f;/^[a-zA-Z].*\./i\mq\.userName='$3'' \
		-e 'bh' \
		-e ':j;/^[a-zA-Z].*\./i\mq\.password='$4'' \
		-e 'bn' \
		-e ':m;n;:n;/^mq\.password\|^mq\.userName/d' \
		-e ':x' \
		$1
		#echo $tmp3
					
	else
	   echo 'error for updating mq... config path is null'
	fi				

}

#dubbo config:  - param1 is app config path;
#				- param2 is zoo keeper url
#
dubboUpdate() {

#	local tmp4=; local flag=

	if [ ""X != "$1"X ]
	then
		echo 'updating dubbo for file '$1'...'
		
		sed -i 's/\(^dubbo\.registry\.address\)=.*/\1='$2'/' $1
					
	else
	   echo 'error for updating dubbo... config path is null'
	fi				

}


#########################lovely delimiter################################################################
# below functions is designed so that user can update as they like by calling functions


#update common configs  - if data need to be updated is all same for each app,call this function
#				param1: what configs need to be changed 
#						-available options for now: redis, oracle, mq, dubbo
uniformUpdate() {

	for file in ${confFiles[@]}
	do
		filePathArr=(`find $conf_root_path -name $file | xargs echo`)
		for file_path in ${filePathArr[@]}
		do
			#echo $file_path
			case $1 in
				redis) 
					redisUpdate "$file_path" "$redisurl" "$redis_pwd" "$redis_masters";;
				oracle) 
					oracleUpdate "$file_path" "$oracle_url" "$user_header" "$or_password";;
				mq) 
					mqUpdate "$file_path" "$mq_url" "$mq_user" "$mq_password";;
				dubbo) 
					dubboUpdate "$file_path" "$dubbo_url";;
				*)
					redisUpdate "$file_path" "$redisurl" "$redis_pwd" "$redis_masters"
					oracleUpdate "$file_path" "$oracle_url" "$user_header" "$or_password"
					mqUpdate "$file_path" "$mq_url" "$mq_user" "$mq_password"
					dubboUpdate "$file_path" "$dubbo_url"
				;;
			esac
		done
	done

}

# update configs that are different between each apps 
#			-		if data need to be updated is different for each app,call this function
#			-	 	param1: application Name that need to be updated
#			-		param2: what config that need to be updated
#			-		param3: file name in which all configures are maintained
separateUpdate() {
	
}

#read port file and update ports accordingly
#while read line
#do
	#echo 'beginning to split line: ' $line
#	array=(`strSplit $line ,`)
	
#	echo "configure sets " "${array[0]}" "${array[1]}" "${array[2]}" "${array[3]}" "${array[4]}" "${array[5]}"
	
#	tomcatPortsUpdate "${array[0]}" "${array[1]}" "${array[3]}" "${array[4]}" 
	
#	jmxUpdate "${array[0]}" "${array[2]}"
	
#done < ports_conf.txt




#script entrance here !
mainLoop() {

	case $1 in
	
	'-help') echo 'you need help on how to use this script !' ;;
	'-uniform') uniformUpdate $2;;
	'-separate') ;;
	*) echo 'you need help on how to use this script !' ;;
	
	esac


}

