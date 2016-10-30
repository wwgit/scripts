#!/bin/bash

##usage
##e.g
###
# ./yum_source_add.sh yum_repo_download_url local_yum_source local_yum_path
#yum_repo_download_url: http://mirrors.163.com/.help/CentOS6-Base-163.repo

#local_yum_source: centos6.5.iso; by default it uses /dev/cdrom so make sure
#related image has been inserted into cdrom 
#
#local_yum_path:it's relative path of repodata dir in which repomod.xml exists
#if platform is redhat: it's probably /server, if centos, it should be null


#distributor and release
distributor=`lsb_release -i|sed -n 's/[a-zA-Z ]\+:\s*\([a-zA-Z]\+$\)/\1/p'`
release=`lsb_release -r|sed -n 's/[a-zA-Z ]\+:\s*\([0-9]\.\?[0-9]\?$\)/\1/p'`
echo "getting system distributor: $distributor"
echo "getting system release: $release"


#getting system cpu arch - i386 or x86_64 (32 bit or 64 bit)
arch=`uname -i`
echo "getting cpu arch: $arch"

#it always should be this dir 
sys_yum_dir=/etc/yum.repos.d
yum_bk_dir=~/sys_bak/yum_bak

mkdir -p $yum_bk_dir

#backup original yum repo files to $USER_HOME/sys_bak/yum_bak first
mv -f $sys_yum_dir/* $yum_bk_dir

#handle first parameter
#if $1 not set, using 163 source by default
yum_download_url=
if [ ""X == "$1"X ];then
	#rep_163=`find $yum_bk_dir -name *163*`
	yum_download_url=http://mirrors.163.com/.help/CentOS6-Base-163.repo
else
	yum_download_url=$1
fi

#verify if repo file exists in local
cd $sys_yum_dir
repo_file=`echo $yum_download_url|sed 's/.*\/\([a-zA-Z0-9\-]\+\.repo$\)/\1/'`
if [ ""X != "$repo_file"X ];then
	#echo $repo_file
	finded=`find $yum_bk_dir -name $repo_file`
	if [ ""X == "$finded"X ];then
			echo "$repo_file not found in local, trying to download from $yum_download_url"			
			wget -c -e robots=off -nd -np $yum_download_url
	else
			echo "repo file $finded already exists,copying to $sys_yum_dir"
			cp -rf $finded $sys_yum_dir
	fi
		
else
	echo "err: url $yum_download_url does Not contain a valid repo file name !"
	#exit $?
fi

#check platform 
output_cent=`echo $distributor|sed -n '/[cC][eE][nN][tT][oO][sS]/p'`
if [ "$output_cent"X == ""X ];then
	
	ot_redhat=`echo $distributor|sed -n '/[rR][eE][dD][hH][aA][tT]/p'`
	
	if [ "$ot_redhat"X == ""X ];then
		echo 'the os platform is probably is not supported by this script'
		exit $?
	else
				
		mkdir -p ~/rpms
		cd ~/rpms
		
		#download yum-3.2.29-40.el6.centos.noarch.rpm
		wget -c -e robots=off -nd -np -r -A 'yum-[0-9].*.rpm' \
			-k http://mirrors.163.com/centos/6.8/os/${arch}/Packages/
		
		#download yum-plugin-fastestmirror-1.1.30-14.el6.noarch.rpm
		wget -c -e robots=off -nd -np -r -A 'yum-plugin-fastestmirror-[0-9].*.rpm' \
			-k http://mirrors.163.com/centos/6.8/os/${arch}/Packages/
		
		#download yum-metadata-parser-1.1.2-16.el6.x86_64.rpm
		wget -c -e robots=off -nd -np -r -A 'yum-metadata-parser-[0-9].*.rpm' \
			-k http://mirrors.163.com/centos/6.8/os/${arch}/Packages/
			
		#download python-iniparse-0.3.1-2.1.el6.noarch.rpm
		#wget -c -e robots=off -nd -np -r -A 'python-iniparse-[0-9].*.rpm' \
			-k http://mirrors.163.com/centos/6.8/os/${arch}/Packages/
		
		#clear original yum rpm of redhat first
		rpm -qa|grep yum|xargs rpm -e --nodeps
		
		#install yum basic rpm packages of centos
		#rpm -ivh python-iniparse-*.rpm
		rpm -ivh yum-metadata-parser-*.rpm
		rpm -ivh yum-[0-9].*.rpm yum-plugin-fastestmirror-*.rpm
		
		cd $sys_yum_dir
		repoChk=`find . -name $repo_file`
		if [ "repoChk"X == ""X ];then
			echo "repo file is Not available in $sys_yum_dir"
		else
			#for redhat series:
			#if release is smaller than 6.8, using 6.8 instead cause 
			#yum source is only available for centos 6.8
			if [ $(echo "6.8>$release"|bc) -eq 1 ];then
				echo 'release version is too old to get relate yum source'
				echo "using 6.8 for centos yum source config instead"
				release=6.8
			fi
			sed -i 's/\$releasever/'$release'/g' $repo_file
		fi
		
	fi
	
fi

#mount source to a local dir
#by default mount cdrom content to /media
mount_info=`df|grep /dev/sr0|sed -n 'p'`

if [ ""X != "$mount_info"X ]
then
	umount /dev/sr0
fi

#handle second parameter local_yum_source
#if second param is null, use /dev/cdrom by default
echo 'try to set local yum source from local installaion image or cdrom'
if [ ""X != "$2"X ]
then
	local_yum_source=$2
else
	echo 'local yum source not set, now set /dev/cdrom as default'
	local_yum_source=/dev/cdrom
fi

#local yum source is mount on /media by default
local_yum_dir=/media
if [ ! -d $local_yum_dir ];then
	echo '$local_yum_dir somehow is not a valid dir'
	echo 'creating a mnt folder for mounting under user home dir'
	mkdir -p ~/mnt
	local_yum_dir=~/mnt
fi 

#handle third parameter local_yum_path
#if local_yum_path is null, just local_yum_dir would be written to local-base.repo
if [ ""X != "$3"X ]
then
	local_yum_config_path=$local_yum_dir/$3
else
	local_yum_config_path=$local_yum_dir
fi
mount $local_yum_source $local_yum_dir

#build local-base.repo file
#if mount local yum source successfully,then generate local-base.repo accordingly
if [ $? -eq 0 ];then
	echo '#local.repo'>>$sys_yum_dir/local-base.repo
	echo '[local-yum-base]'>>$sys_yum_dir/local-base.repo
	echo 'name=local-base'>>$sys_yum_dir/local-base.repo
	echo "baseurl=file://$local_yum_config_path">>\
	$sys_yum_dir/local-base.repo
	echo 'gpgcheck=0'>>$sys_yum_dir/local-base.repo
fi

yum clean all

yum makecache

