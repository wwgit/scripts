#!/bin/bash

ret=`cat ~/.bash_profile|grep 'FTP_ROOT='`


if [ ""X = "$ret"X ]; then
   FTP_ROOT="${0##*/}";
   echo "export FTP_ROOT=$FTP_ROOT">>~/.bash_profile;
   echo "Note ! envrionment variable MYSHELL_ROOT has been set to 
        ~/.bash_profile, but it won't take effect untill system is rebooted !"
fi

FTP_SITE=$1;
DOWNLOAD_TARGET="get/shellscripts";
SAVE_FOLDER="downloads";

ret=`cat ~/.bash_profile|grep 'MYSHELL_ROOT='`


if [ ""X = "$ret"X ]; then
   MYSHELL_ROOT=${FTP_ROOT}/${SAVE_FOLDER}/${FTP_SITE}/${DOWNLOAD_TARGET};
   echo "export MYSHELL_ROOT=$MYSHELL_ROOT">>~/.bash_profile;
   echo "Note ! envrionment variable MYSHELL_ROOT has been set to 
         ~/.bash_profile, but it won't take effect untill system is rebooted !"
fi

#ret=`echo $ret|grep $1`


if [[ "$ret" =~ ${1} ]];then
    echo "FTP_SITE not changed !"
else
   MYSHELL_ROOT=${FTP_ROOT}/${SAVE_FOLDER}/${FTP_SITE}/${DOWNLOAD_TARGET};
  # mkdir -p ~/myshell_bk;
   cp -f ~/.bash_profile ./bash_profile_myshell_bk;
   sed -i "s/downloads\/[0-9.]\+\/get/downloads\/$FTP_SITE\/get/" ~/.bash_profile
   #echo "export MYSHELL_ROOT=$MYSHELL_ROOT">>~/.bash_profile;~/.bash_profile
   echo "FTP_SITE changed, MYSHELL_ROOT has been updated !"
   cat ~/.bash_profile
fi


echo $FTP_ROOT
echo $MYSHELL_ROOT

wget -P ./${SAVE_FOLDER} ftp://${FTP_SITE}:21/${DOWNLOAD_TARGET}/* \
--ftp-user=Ftp_Admin --ftp-password=0445465674 -r \
2>logs/ftp_errors.log

