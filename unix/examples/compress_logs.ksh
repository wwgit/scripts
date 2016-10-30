# compress all log files before the specified date

#!/usr/bin/ksh

gzip=/usr/contrib/bin/gzip

WSCA1_LOG_DIR=/opt/sasuapps/wsca/instances/wsca1/log

WSCA2_LOG_DIR=/opt/sasuapps/wsca/instances/wsca2/log

WSCA3_LOG_DIR=/opt/sasuapps/wsca/instances/wsca3/log

WSCA4_LOG_DIR=/opt/sasuapps/wsca/instances/wsca4/log

WSCA5_LOG_DIR=/opt/sasuapps/wsca/instances/wsca5/log

WSCA6_LOG_DIR=/opt/sasuapps/wsca/instances/wsca6/log

WSCA7_LOG_DIR=/opt/sasuapps/wsca/instances/wsca7/log

WSCA8_LOG_DIR=/opt/sasuapps/wsca/instances/wsca8/log


echo ===============================Script Start==============================


if [ -d "$WSCA1_LOG_DIR" ]; then

	echo ========================
	echo    Compress WSCA1 LOG START
	echo    `date`
	echo ========================
	echo

	cd ${WSCA1_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec $gzip -f {} \;
		    
	find . -name 'wsca*_stdout.log*' -mtime +$1 -exec $gzip -f {} \;

	find . -name 'payload.log.*' -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca.log.* -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca_sql.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/enotify.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/autoload.log.* -mtime +$1 -exec $gzip -f {} \;
	
	echo ========================
	echo    Compress WSCA1 LOG END
	echo    `date`
	echo ========================
	echo
else
        echo directory $WSCA1_LOG_DIR is not exist
fi

echo ===================================================

if [ -d "$WSCA2_LOG_DIR" ]; then

	echo ========================
	echo    Compress WSCA2 LOG START
	echo    `date`
	echo ========================
	echo

	cd ${WSCA2_LOG_DIR}

	
	find . -name 'send_to_sap.*.log' -mtime +$1 -exec $gzip -f {} \;
		   
	find . -name 'wsca*_stdout.log*' -mtime +$1 -exec $gzip -f {} \;

	find . -name 'payload.log.*' -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca.log.* -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca_sql.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/enotify.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/autoload.log.* -mtime +$1 -exec $gzip -f {} \;

	echo ========================
	echo    Compress WSCA2 LOG END
	echo    `date`
	echo ========================
	echo
else
        echo directory $WSCA2_LOG_DIR is not exist
fi

echo ===================================================


if [ -d "$WSCA3_LOG_DIR" ]; then

	echo ========================
	echo    Compress WSCA3 LOG START
	echo    `date`
	echo ========================
	echo

	cd ${WSCA3_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec $gzip -f {} \;
		      
	find . -name 'wsca*_stdout.log*' -mtime +$1 -exec $gzip -f {} \;
		      
	find . -name 'payload.log.*' -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca.log.* -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca_sql.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/enotify.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/autoload.log.* -mtime +$1 -exec $gzip -f {} \;

	echo ========================
	echo    Compress WSCA3 LOG END
	echo    `date`
	echo ========================
	echo

else
        echo directory $WSCA3_LOG_DIR is not exist
fi

echo ===================================================



if [ -d "$WSCA4_LOG_DIR" ]; then

	echo ========================
	echo    Compress WSCA4 LOG START
	echo    `date`
	echo ========================
	echo

	cd ${WSCA4_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec $gzip -f {} \;
		    
	find . -name 'wsca*_stdout.log*' -mtime +$1 -exec $gzip -f {} \;

	find . -name 'payload.log.*' -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca.log.* -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca_sql.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/enotify.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/autoload.log.* -mtime +$1 -exec $gzip -f {} \;

	echo ========================
	echo    Compress WSCA4 LOG END
	echo    `date`
	echo ========================
	echo
else
        echo directory $WSCA4_LOG_DIR is not exist
fi

echo ===================================================



if [ -d "$WSCA5_LOG_DIR" ]; then

	echo ========================
	echo    Compress WSCA5 LOG START
	echo    `date`
	echo ========================
	echo

	cd ${WSCA5_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec $gzip -f {} \;

	find . -name 'wsca*_stdout.log*' -mtime +$1 -exec $gzip -f {} \;

	find . -name 'payload.log.*' -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca.log.* -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca_sql.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/enotify.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/autoload.log.* -mtime +$1 -exec $gzip -f {} \;

	echo ========================
	echo    Compress WSCA5 LOG END
	echo    `date`
	echo ========================
	echo

else
        echo directory $WSCA5_LOG_DIR is not exist
fi

echo ===================================================


if [ -d "$WSCA6_LOG_DIR" ]; then

	echo ========================
	echo    Compress WSCA6 LOG START
	echo    `date`
	echo ========================
	echo

	cd ${WSCA6_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec $gzip -f {} \;

	find . -name 'wsca*_stdout.log*' -mtime +$1 -exec $gzip -f {} \;

	find . -name 'payload.log.*' -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca.log.* -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca_sql.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/enotify.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/autoload.log.* -mtime +$1 -exec $gzip -f {} \;

	echo ========================
	echo    Compress WSCA6 LOG END
	echo    `date`
	echo ========================
	echo

else
        echo directory $WSCA6_LOG_DIR is not exist
fi

echo ===================================================


if [ -d "$WSCA7_LOG_DIR" ]; then

	echo ========================
	echo    Compress WSCA7 LOG START
	echo    `date`
	echo ========================
	echo

	cd ${WSCA7_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec $gzip -f {} \;

	find . -name 'wsca*_stdout.log*' -mtime +$1 -exec $gzip -f {} \;

	find . -name 'payload.log.*' -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca.log.* -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca_sql.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/enotify.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/autoload.log.* -mtime +$1 -exec $gzip -f {} \;

	echo ========================
	echo    Compress WSCA7 LOG END
	echo    `date`
	echo ========================
	echo

else
        echo directory $WSCA7_LOG_DIR is not exist
fi

echo ===================================================



if [ -d "$WSCA8_LOG_DIR" ]; then

	echo ========================
	echo    Compress WSCA8 LOG START
	echo    `date`
	echo ========================
	echo

	cd ${WSCA8_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec $gzip -f {} \;

	find . -name 'wsca*_stdout.log*' -mtime +$1 -exec $gzip -f {} \;

	find . -name 'payload.log.*' -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca.log.* -mtime +$1 -exec $gzip -f {} \;

	find */services/sca/sca_sql.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/enotify.log.* -mtime +$1 -exec $gzip -f {} \;
	
	find */services/sca/autoload.log.* -mtime +$1 -exec $gzip -f {} \;

	echo ========================
	echo    Compress WSCA8 LOG END
	echo    `date`
	echo ========================
	echo

else
        echo directory $WSCA8_LOG_DIR is not exist
fi

echo ========================================================================

echo ===============================Script End===============================
