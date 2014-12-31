# VerifyDelResult.ksh
#!/usr/bin/ksh

SHELL_SCRIPT_DIR=/opt/sasuapps/wsca/bin/
TEST_SCRIPT_DIR=/opt/sasuapps/wsca/bin/TestScript

	echo ================================
	echo    VERIFYING DELETE RESULT START
	echo    `date`
	echo ================================
	echo
	#o -path "./16.236.24.78" -o -path "./16.236.24.77"
	if [ -d "$1" ];then
	  cd $1
	  #find . ! -name "." -type d -prune -o -type f -name "send_to_sap.*.log" -mtime +$2 1>>$TEST_SCRIPT_DIR/wsca_DelLogResult.log
	  find . \( -path "./logbackup" -o \
	  -path "./compressfilebackup" -o\
	  -path "./16.236.24.78" -o\
	  -path "./16.236.24.77" \) -prune -o -name "send_to_sap.*.log" -mtime +$2 -print 1>>$TEST_SCRIPT_DIR/wsca_DelLogResult.log

      find . \( -path "./logbackup" -o \
	            -path "./compressfilebackup" -o \
				-path "./16.236.24.78" -o \
				-path "./16.236.24.77" \) -prune -o -name "updateCarePacks_*.log" -mtime +$2 -print 1>>$TEST_SCRIPT_DIR/wsca_DelLogResult.log
				
	  find . \( -path "./logbackup" -o \
	            -path "./compressfilebackup" -o \
				-path "./16.236.24.78" -o \
				-path "./16.236.24.77" \) -prune -o -name "ManualLinkCarePackRpt_*.log" -mtime +$2 -print 1>>$TEST_SCRIPT_DIR/wsca_DelLogResult.log		
		
     find . \( -path "./logbackup" -o \
	            -path "./compressfilebackup" -o \
				-path "./16.236.24.78" -o \
				-path "./16.236.24.77" \) -prune -o -name "wsca*_stderr_log_*.tar.Z" -mtime +$3 -print 1>>$TEST_SCRIPT_DIR/wsca_DelTarZresult.log	
				
	 find . \( -path "./logbackup" -o \
	            -path "./compressfilebackup" -o \
				-path "./16.236.24.78" -o \
				-path "./16.236.24.77" \) -prune -o -name "wsca*_stdout_log_*.tar.Z" -mtime +$3 -print 1>>$TEST_SCRIPT_DIR/wsca_DelTarZresult.log

     find . \( -path "./logbackup" -o \
	            -path "./compressfilebackup" -o \
				-path "./16.236.24.78" -o \
				-path "./16.236.24.77" \) -prune -o -name "send_to_sap.*.gz" -mtime +$3 -print 1>>$TEST_SCRIPT_DIR/wsca_DelGZresult.log			
				
     find . \( -path "./logbackup" -o \
	            -path "./compressfilebackup" -o \
				-path "./16.236.24.78" -o \
				-path "./16.236.24.77" \) -prune -o -name "wsca*_stdout.*.gz" -mtime +$3 -print 1>>$TEST_SCRIPT_DIR/wsca_DelGZresult.log
	
	find . \( -path "./logbackup" -o \
	            -path "./compressfilebackup" -o \
				-path "./16.236.24.78" -o \
				-path "./16.236.24.77" \) -prune -o -name "payload.log.*.gz" -mtime +$3 -print 1>>$TEST_SCRIPT_DIR/wsca_DelGZresult.log
	
	else
	  echo directory $1 not exist
	fi
	cd ${SHELL_SCRIPT_DIR}
		
	echo ================================
	echo    VERIFYING DELETE RESULT END
	echo    `date`
	echo ================================
	echo
	
	
	