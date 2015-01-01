# PrepareLogData.ksh
#!/usr/bin/ksh

SHELL_SCRIPT_DIR=/opt/sasuapps/wsca/bin/
TEST_SCRIPT_DIR=/opt/sasuapps/wsca/bin/TestScript

	echo =================================== 1>>$TEST_SCRIPT_DIR/test.log
	echo    Prepare  $1 Log file Data START 1>>$TEST_SCRIPT_DIR/test.log
	echo    `date` 1>>$TEST_SCRIPT_DIR/test.log
	echo =================================== 1>>$TEST_SCRIPT_DIR/test.log
	echo 1>>$TEST_SCRIPT_DIR/test.log
if [ -d "$1" ];then
    cd $1
	find . -name 'send_to_sap.*.log' -mtime +$2|cp send_to_sap.*.log ./logbackup  
	if [ $? -eq 0 ]; then	
		echo send_to_sap log backup done successfully! 1>>$TEST_SCRIPT_DIR/test.log
	else
		echo No log files exist under this folder! 1>>$TEST_SCRIPT_DIR/test.log
		echo creating testing data for send_to_sap log file...
		touch send_to_sap.01.log			
	fi	
	
	find . -name 'updateCarePacks_*.log' -mtime +$2|cp updateCarePacks_*.log ./logbackup
	if [ $? -eq 0 ]; then
	   echo updateCarePacks log backup done successfully! 1>>$TEST_SCRIPT_DIR/test.log
	else
	   echo No updateCarePacks log files exist under this folder! 1>>$TEST_SCRIPT_DIR/test.log
	   echo creating testing data for updateCarePacks log file...
	   touch updateCarePacks_01.log 
	fi
	
	find . -name 'ManualLinkCarePackRpt_*.log' -mtime +$2|cp ManualLinkCarePackRpt_*.log ./logbackup
    if [ $? -eq 0 ]; then
	   echo ManualLinkCarePackRpt log backup done successfully! 1>>$TEST_SCRIPT_DIR/test.log
	else
	   echo No ManualLinkCarePackRpt log files exist under this folder! 1>>$TEST_SCRIPT_DIR/test.log
	   echo creating testing data for ManualLinkCarePackRpt log file...
	   touch ManualLinkCarePackRpt_01.log 
	fi
	
	find . -name 'payload.log.*' -mtime +$1|cp payload.log.* ./logbackup	
	if [ $? -eq 0 ]; then
		echo log.* backup done successfully! 1>>$TEST_SCRIPT_DIR/test.log
	else
		echo No log.* files exist under this folder! 1>>$TEST_SCRIPT_DIR/test.log
		touch payload.log.01
	fi
	
	cd ${TEST_SCRIPT_DIR}
else
    echo directory $1 not exist	
fi	
	echo ================================ 1>>$TEST_SCRIPT_DIR/test.log
	echo    Prepare $1 Log file Data END 1>>$TEST_SCRIPT_DIR/test.log
	echo    `date` 1>>$TEST_SCRIPT_DIR/test.log
	echo ================================ 1>>$TEST_SCRIPT_DIR/test.log
	echo		1>>$TEST_SCRIPT_DIR/test.log   