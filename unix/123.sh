#!/bin/bash

root_path='/home/tomcat/lpt10'
web_conf_xml='conf/server.xml'
jmx_conf_file='run.sh'
ip='192.168.220.101:26379,192.168.220.111:26379,192.168.220.131:26379'
redis_pwd='howbuy'
ip_reg='\([0-9]\{1,3\}\.\?\)*'
port_reg='[0-9]\{4,5\}'
redis_head='\(^redis\.sentinels=\|^redis\.serverPath=\)'
redis_reg=''$redis_head'\('$ip_reg':'$port_reg',\?\)*'
redisConfFiles=('config.properties' 'globals.properties')

#oracle
oracle_url='jdbc:oracle:thin:@1.1.1.111:1521:hbqa3'
oracleConfFiles=('config.properties' 'jdbc.properties')

#mq
mqConfFiles=('config.properties' 'mq.properties' 'globals.properties')
mq_url=''

#update redis config - param1 is app config path;
# 					   param2 is redis address/addresses; param3 is redis port
redisUpdate() {

	local tmp=; local flag=
	
	for file in ${redisConfFiles[@]}
	do
		tmp=`find $1 -name "$file" | xargs echo`
		if [ ""X != "$tmp"X ]
		then
		   echo 'find file '$tmp
		   sed -i -e '/'$redis_head'/ba;be;:a;s/'$redis_reg'/\1'$2'/;n;' \
		   -e '/\(^redis\.password=\)/bc;:d;/^redis\..*=/i\redis\.password='$3'' \
		   -e 'tf;p;' \
		   -e ':c;s/\(^redis\.password=\).*/\1'$3'/' \
		   -e ':f;n;:e;/[^r][^e][^d][^i][^s]\..*/bx;:j;/^redis\.password=/d;:x' \
		   $file		   
		else
		   echo 'cannot find file '$file 
		fi
		
				
		#redis\.serverPath=|
	done

}

#
oracleUpdate() {

	local tmp=; local flag=
	for file in ${oracleConfFiles[@]}
	do
		tmp=`find $1 -name "$file" | xargs echo`
		if [ ""X != "$tmp"X ]
		then
			echo 'find file '$tmp
			sed -i -e '/^\([a-zA-Z]\+\.\?\)*=oracle\.jdbc\.driver\.OracleDriver$/ba;bx' \
			-e ':a;n;s/^\(\([a-zA-Z]\+\.\?\)*\)=jdbc:oracle:.*/\1='$2'/;tc;bx' \
			-e ':c;n;s/^\(\([a-zA-Z]\+\.\?\)*user.*\)=.*/\1='$3'/;te;bx' \
			-e ':e;n;s/^\(\([a-zA-Z]\+\.\?\)*password\)=.*/\1='$4'/' \
			-e ':x' \
			$file
		else
		   echo 'cannot find file '$file
		fi		
	done

}

#update mq config - param1 is app config path;
#					param2 is mq url; param3 is mq username; param4 is mq password
#	
mqUpdate() {

	local tmp2=; local flag=
	for file in ${redisConfFiles[@]}
	do
		tmp2=`find $1 -name "$file" | xargs echo`
		if [ ""X != "$tmp"X ]
		then
			echo 'find file '$tmp2
			sed -i -e 's/^\(mq.brokerURL=\).*/\1'$2'/;ta;bx' \
			-e ':a;n;s/^\(mq.userName=\).*/\1'$3'/;tc;be' \
			-e ':c;n;s/^\(mq.password=\).*/\1'$4'/;bx' \
			-e ':e;///' \
			-e ':x' \
			$file
		else
		   echo 'cannot find file '$file
		fi				
	done

}

#redisUpdate . $ip 'howbuy'
oracleUpdate . $oracle_url '789000' '11111000'
