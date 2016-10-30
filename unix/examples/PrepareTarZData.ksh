# PrepareTarZData.ksh
#!/usr/bin/ksh

SHELL_SCRIPT_DIR=/opt/sasuapps/wsca/bin/
TEST_SCRIPT_DIR=/opt/sasuapps/wsca/bin/TestScript

	echo ====================================== 1>>$TEST_SCRIPT_DIR/test.log
	echo    Prepare $1 tar.Z file Data START 1>>$TEST_SCRIPT_DIR/test.log
	echo    `date` 1>>$TEST_SCRIPT_DIR/test.log
	echo ======================================1>>$TEST_SCRIPT_DIR/test.log
	echo        1>>$TEST_SCRIPT_DIR/test.log
if [ -d "$1" ];then
    cd $1
	find . -name 'wsca*_stderr_log_*.tar.Z' -mtime +$3|cp wsca*_stderr_log_*.tar.Z ./compressfilebackup
	if [ $? -eq 0 ]; then	
		echo wsca_stderr_log_tar.Z backup done successfully! 1>>$TEST_SCRIPT_DIR/test.log
	else
		echo No wsca_stderr_log_tar.Z files exist under this folder! 1>>$TEST_SCRIPT_DIR/test.log
		echo creating testing data for wsca_stderr_log_tar.Z file...
		touch wsca01_stderr_log_01.tar.Z
		touch wsca02_stdout_log_02.tar.Z 
	fi 
	
	find . -name 'wsca*_stdout_log_*.tar.Z' -mtime +$3|cp wsca*_stdout_log_*.tar.Z ./compressfilebackup
	if [ $? -eq 0 ]; then
	   echo wsca_stdout_log_tar.Z backup done successfully! 1>>$TEST_SCRIPT_DIR/test.log
	else
	   echo No wsca_stdout_log_tar.Z files exist under this folder! 1>>$TEST_SCRIPT_DIR/test.log
	   echo creating testing data for wsca_stdout_log_tar.Z file...
	   touch wsca01_stderr_log_01.tar.Z
	   touch wsca02_stdout_log_02.tar.Z
	fi
	
	cd ${TEST_SCRIPT_DIR}
else
    echo directory $1 not exist
fi 	

	echo ================================== 1>>$TEST_SCRIPT_DIR/test.log
	echo    Prepare $1 tar.Z file Data END 1>>$TEST_SCRIPT_DIR/test.log
	echo    `date` 1>>$TEST_SCRIPT_DIR/test.log
	echo ================================== 1>>$TEST_SCRIPT_DIR/test.log
	echo	    1>>$TEST_SCRIPT_DIR/test.log