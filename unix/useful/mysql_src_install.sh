#!/bin/bash

#$1: source tar path
#$2: target path where tar content is unzip to
# if $2 is not given, use source path as target path
# if $1 is not given, return 1
srcpath=
ret=0


if [ -s "$1" ];then
 #get dir path of source package 
 srcpath=`cat "$1"|sed -n 's/\/[^ \/]\+\.tar$\|\.gz$//p'`
else
	
fi

if [ ! -d "$srcpath" ];then
	mkdir -p "$srcpath" || exit 1
	chmod 0755 "$srcpath"
fi



pids=()
#getAllPid
#$1: regular expression for grep 
#- expression to filter the ps result
getAllPid(){
	
	local pid_file=~/pid.txt
	touch $pid_file
	#$1 should be a grep expression -'mysql'
	ps aux|grep -i $1>$pid_file

	i=0
	while read line
	do
		echo 'read line: '$line
		pids[$i]=`echo $line|sed 's/^[a-zA-Z0-9]\+\s\([0-9]\+\)\s.*/\1/'`
		#echo 'get pid: '${pids[$i]}

		i=$((i+=1))
	done <$pid_file
	
	rm -rf $pid_file
	#echo "${pids[@]}"
	
}

#getPInfoWithPid
#pid - get ps info about that pid
#expression to filter out detailed info of ps result 
getPsInfoWithPid(){
	
	info=`ps aux|grep $1|grep "$2"`
	echo "$info"

}

#get all process id related to mysql first
getAllPid '^mysql\s.*[-][-]pid-file=.*mysql.*'
echo ${pids[@]}

#keep base dir and data dir for all installed mysql instances
basedirs=()
datadirs=()
for pid in ${pids[@]}
do
	pinfo_file=~/pinfo_${pid}.txt
	touch $pinfo_file
	ps aux|grep $pid>$pinfo_file
	
	local i=0
	while read line
	do
		pinfo_base=`echo $line|sed 's/.*[-][-]basedir=\(\/[^ ]\+\)\s\?.*/\1/'`
		pinfo_data=`echo $line|sed 's/.*[-][-]datadir=\(\/[^ ]\+\)\s\?.*/\1/'`
		
		#assume dir name does Not contain blank
		#when use ps aux|grep pid, it will always get two line
		#one is grep process which we don't want
		#we need get rid of this grep process info
		basedirs[$i]=`echo $pinfo_base|sed -n '/.*[ ]\+.*/!p'`
		datadirs[$i]=`echo $pinfo_data|sed -n '/.*[ ]\+.*/!p'`
		echo 'get process info: '$pinfo
		echo 'get basedir: '$basedir
		
		#make sure both base dir and data dir need are unique
		if [];then
			
		fi
		
		
	done <$pinfo_file
	
done


#mkdir -p /data/mysql/backup/leon_bk



