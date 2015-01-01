# Test delete_logs.ksh
#!/usr/bin/ksh

SHELL_SCRIPT_DIR=/opt/sasuapps/wsca/bin/
TEST_SCRIPT_DIR=/opt/sasuapps/wsca/bin/TestScript
WSCA1_LOG_DIR=/opt/sasuapps/wsca/instances/wsca1/log
WSCA2_LOG_DIR=/opt/sasuapps/wsca/instances/wsca2/log
WSCA3_LOG_DIR=/opt/sasuapps/wsca/instances/wsca3/log
WSCA4_LOG_DIR=/opt/sasuapps/wsca/instances/wsca4/log
WSCA5_LOG_DIR=/opt/sasuapps/wsca/instances/wsca5/log
WSCA6_LOG_DIR=/opt/sasuapps/wsca/instances/wsca6/log
WSCA7_LOG_DIR=/opt/sasuapps/wsca/instances/wsca7/log
WSCA8_LOG_DIR=/opt/sasuapps/wsca/instances/wsca8/log
WSCA_NON_LOG=/opt/sasuapps/wsca/prod/rnwl_extracts

echo =============================
echo    Delete logs Testing START
echo =============================

echo ===============================Script Start==============================
	echo ===================================
	echo    VERIFY DELETE_LOGS SCRIPT START
	echo    `date`
	echo ===================================
	echo
	
	cd ${TEST_SCRIPT_DIR}
	
    PrepareLogData.ksh $WSCA1_LOG_DIR $1 $2
	PrepareTarZData.ksh $WSCA1_LOG_DIR $1 $2
	Prepare_gzData.ksh $WSCA1_LOG_DIR $1 $2
	
	PrepareLogData.ksh $WSCA2_LOG_DIR $1 $2
	PrepareTarZData.ksh $WSCA2_LOG_DIR $1 $2
	Prepare_gzData.ksh $WSCA2_LOG_DIR $1 $2
	
    PrepareLogData.ksh $WSCA3_LOG_DIR $1 $2
	PrepareTarZData.ksh $WSCA3_LOG_DIR $1 $2
	Prepare_gzData.ksh $WSCA3_LOG_DIR $1 $2
	
	PrepareLogData.ksh $WSCA4_LOG_DIR $1 $2
	PrepareTarZData.ksh $WSCA4_LOG_DIR $1 $2
	Prepare_gzData.ksh $WSCA4_LOG_DIR $1 $2
	
	PrepareLogData.ksh $WSCA5_LOG_DIR $1 $2
	PrepareTarZData.ksh $WSCA5_LOG_DIR $1 $2
	Prepare_gzData.ksh $WSCA5_LOG_DIR $1 $2
	
	PrepareLogData.ksh $WSCA6_LOG_DIR $1 $2
	PrepareTarZData.ksh $WSCA6_LOG_DIR $1 $2
	Prepare_gzData.ksh $WSCA6_LOG_DIR $1 $2
	
	PrepareLogData.ksh $WSCA7_LOG_DIR $1 $2
	PrepareTarZData.ksh $WSCA7_LOG_DIR $1 $2
	Prepare_gzData.ksh $WSCA7_LOG_DIR $1 $2
	
	PrepareLogData.ksh $WSCA8_LOG_DIR $1 $2
	PrepareTarZData.ksh $WSCA8_LOG_DIR $1 $2
	Prepare_gzData.ksh $WSCA8_LOG_DIR $1 $2
		  
    cd ${SHELL_SCRIPT_DIR}
	delete_logs.ksh $1 $2
	
	#verify the running result
	cd ${TEST_SCRIPT_DIR}
	VerifyDelResult.ksh $WSCA1_LOG_DIR $1 $2
	VerifyDelResult.ksh $WSCA2_LOG_DIR $1 $2
	VerifyDelResult.ksh $WSCA3_LOG_DIR $1 $2
	VerifyDelResult.ksh $WSCA4_LOG_DIR $1 $2
	VerifyDelResult.ksh $WSCA5_LOG_DIR $1 $2
	VerifyDelResult.ksh $WSCA6_LOG_DIR $1 $2
	VerifyDelResult.ksh $WSCA7_LOG_DIR $1 $2
	VerifyDelResult.ksh $WSCA8_LOG_DIR $1 $2
		
echo ===============================Script End===============================

echo ===============================
echo    Delete logs Testing COMPLETE
echo ===============================
