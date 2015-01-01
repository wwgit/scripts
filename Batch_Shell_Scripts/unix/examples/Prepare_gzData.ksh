# Prepare_gzData.ksh
#!/usr/bin/ksh

SHELL_SCRIPT_DIR=/opt/sasuapps/wsca/bin/
TEST_SCRIPT_DIR=/opt/sasuapps/wsca/bin/TestScript

	echo ================================== 1>>$TEST_SCRIPT_DIR/test.log
	echo    Prepare $1 gz file Data START 1>>$TEST_SCRIPT_DIR/test.log
	echo    `date` 1>>$TEST_SCRIPT_DIR/test.log
	echo ================================== 1>>$TEST_SCRIPT_DIR/test.log
	echo    1>>$TEST_SCRIPT_DIR/test.log
if [ -d "$1" ];then
    cd $1
	find . -name 'send_to_sap.*.log.gz' -mtime +$3|cp send_to_sap.*.gz ./compressfilebackup
	if [ $? -eq 0 ]; then	
		echo send_to_sap_gz file backup done successfully! 1>>$TEST_SCRIPT_DIR/test.log
	else
		echo No send_to_sap_gz files exist under this folder! 1>>$TEST_SCRIPT_DIR/test.log
		echo creating testing data for send_to_sap_gz file...
		touch send_to_sap.01.log.gz
	fi
	
	find . -name 'wsca*_stdout.*.gz' -mtime +$3|cp wsca*_stdout.*.gz ./compressfilebackup
	if [ $? -eq 0 ]; then	
		echo wsca_stdout_gz file backup done successfully! 1>>$TEST_SCRIPT_DIR/test.log
	else
		echo No wsca_stdout_gz files exist under this folder! 1>>$TEST_SCRIPT_DIR/test.log
		echo creating testing data for wsca_stdout_gz file...
		touch wsca01_stdout.01.gz
	fi
	
	find . -name 'payload.log.*.gz' -mtime +$3|cp payload.log.*.gz ./compressfilebackup
	if [ $? -eq 0 ]; then	
		echo payload.log.gz file backup done successfully! 1>>$TEST_SCRIPT_DIR/test.log
	else
		echo No gz files exist under this folder! 1>>$TEST_SCRIPT_DIR/test.log
		echo creating testing data for payload.log.gz file...
		touch payload.log.01.gz
	fi
	
	cd ${TEST_SCRIPT_DIR}
else
    echo directory $1 not exist
fi	

	echo =============================== 1>>$TEST_SCRIPT_DIR/test.log
	echo    Prepare $1 gz file Data END 1>>$TEST_SCRIPT_DIR/test.log
	echo    `date`   1>>$TEST_SCRIPT_DIR/test.log
	echo =============================== 1>>$TEST_SCRIPT_DIR/test.log
	echo	   1>>$TEST_SCRIPT_DIR/test.log 