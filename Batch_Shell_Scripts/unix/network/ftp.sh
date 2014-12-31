#!/bin/bash

#/usr/bin/ftp -i -n<<EOF
#open 192.168.1.3
#user Ftp_Admin 0445465674
#cd get/shellscripts
#bin
#
#mget *
#cd examples
#mget *
#cd ..
#cd misc
#mget *
#cd ..
#cd network
#mget *
#cd ..
#cd os
#mget *
#cd ..
#bye


mkdir -p logs

wget -p ./downloads ftp://$1:21/get/shellscripts/* --ftp-user=Ftp_Admin --ftp-password=0445465674 -r




