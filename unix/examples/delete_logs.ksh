# delete all old log files before the specified date
# $1 means that the modified date of the file which will be deleted is more than $1 days before today.
# $2, same meaning as $1,but it is used on compressed files

#!/usr/bin/ksh

WSCA1_LOG_DIR=/opt/sasuapps/wsca/instances/wsca1/log
WSCA2_LOG_DIR=/opt/sasuapps/wsca/instances/wsca2/log
WSCA3_LOG_DIR=/opt/sasuapps/wsca/instances/wsca3/log
WSCA4_LOG_DIR=/opt/sasuapps/wsca/instances/wsca4/log
WSCA5_LOG_DIR=/opt/sasuapps/wsca/instances/wsca5/log
WSCA6_LOG_DIR=/opt/sasuapps/wsca/instances/wsca6/log
WSCA7_LOG_DIR=/opt/sasuapps/wsca/instances/wsca7/log
WSCA8_LOG_DIR=/opt/sasuapps/wsca/instances/wsca8/log
WSCA_NON_LOG=/opt/sasuapps/wsca/prod/rnwl_extracts


echo ============================
echo    Delete LOGS START
echo ============================

echo ===============================Script Start==============================


if [ -d "$WSCA1_LOG_DIR" ]; then

	echo ===========================
	echo    Delete WSCA1 LOG START
	echo    `date`
	echo ===========================
	echo

	cd ${WSCA1_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec rm {} \;
	find . -name 'updateCarePacks_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'ManualLinkCarePackRpt_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'payload.log.*' -mtime +$1 -exec rm {} \;
	find */services/sca/ -mtime +$1 -exec rm {} \;

	find . -name 'wsca*_stderr_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'send_to_sap.*.log.gz' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout.*.gz' -mtime +$2 -exec rm {} \;
	find . -name 'payload.log.*.gz' -mtime +$2 -exec rm {} \;


	find */services/sca/sca.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/sca_sql.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/enotify.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/autoload.log.*.gz -mtime +$2 -exec rm {} \;

	echo ===========================
	echo    Delete WSCA1 LOG END
	echo    `date`
	echo ===========================
	echo

else
        echo directory $WSCA1_LOG_DIR is not exist
fi

echo ===================================================


if [ -d "$WSCA2_LOG_DIR" ]; then

	echo ============================
	echo    Delete WSCA2 LOG START
	echo    `date`
	echo ============================
	echo

	cd ${WSCA2_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec rm {} \;
	find . -name 'updateCarePacks_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'ManualLinkCarePackRpt_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'payload.log.*' -mtime +$1 -exec rm {} \;
	find */services/sca/ -mtime +$1 -exec rm {} \;

	find . -name 'wsca*_stderr_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'send_to_sap.*.log.gz' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout.*.gz' -mtime +$2 -exec rm {} \;
	find . -name 'payload.log.*.gz' -mtime +$2 -exec rm {} \;

	find */services/sca/sca.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/sca_sql.log.*.gz -mtime +$2 -exec rm {} \
	find */services/sca/enotify.log.*.gz -mtime +$2 -exec rm {} \;	   
	find */services/sca/autoload.log.*.gz -mtime +$2 -exec rm {} \;

	echo ============================
	echo    Delete WSCA2 LOG END
	echo    `date`
	echo ============================
	echo

else
        echo directory $WSCA2_LOG_DIR is not exist
fi

echo ===================================================


if [ -d "$WSCA3_LOG_DIR" ]; then

	echo ===========================
	echo    Delete WSCA3 LOG START
	echo    `date`
	echo ===========================
	echo

	cd ${WSCA3_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec rm {} \;
	find . -name 'updateCarePacks_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'ManualLinkCarePackRpt_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'payload.log.*' -mtime +$1 -exec rm {} \;
	find */services/sca/ -mtime +$1 -exec rm {} \;

	find . -name 'wsca*_stderr_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'send_to_sap.*.log.gz' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout.*.gz' -mtime +$2 -exec rm {} \;
	find . -name 'payload.log.*.gz' -mtime +$2 -exec rm {} \;

	find */services/sca/sca.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/sca_sql.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/enotify.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/autoload.log.*.gz -mtime +$2 -exec rm {} \;
		      
	echo =============================
	echo    Delete WSCA3 LOG END
	echo    `date`
	echo =============================
	echo

else
        echo directory $WSCA3_LOG_DIR is not exist
fi

echo ===================================================


if [ -d "$WSCA4_LOG_DIR" ]; then

	echo ===========================
	echo    Delete WSCA4 LOG START
	echo    `date`
	echo ===========================
	echo

	cd ${WSCA4_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec rm {} \;
	find . -name 'updateCarePacks_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'ManualLinkCarePackRpt_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'payload.log.*' -mtime +$1 -exec rm {} \;
	find */services/sca/ -mtime +$1 -exec rm {} \;

	find . -name 'wsca*_stderr_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'send_to_sap.*.log.gz' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout.*.gz' -mtime +$2 -exec rm {} \;
	find . -name 'payload.log.*.gz' -mtime +$2 -exec rm {} \;

	find */services/sca/sca.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/sca_sql.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/enotify.log.*.gz -mtime +$2 -exec rm {} \;		   
	find */services/sca/autoload.log.*.gz -mtime +$2 -exec rm {} \;

	echo =============================
	echo    Delete WSCA4 LOG END
	echo    `date`
	echo =============================
	echo

else
        echo directory $WSCA4_LOG_DIR is not exist
fi

echo ===================================================


if [ -d "$WSCA5_LOG_DIR" ]; then

	echo ===========================
	echo    Delete WSCA5 LOG START
	echo    `date`
	echo ===========================
	echo

	cd ${WSCA5_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec rm {} \;
	find . -name 'updateCarePacks_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'ManualLinkCarePackRpt_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'payload.log.*' -mtime +$1 -exec rm {} \;
	find */services/sca/ -mtime +$1 -exec rm {} \;

	find . -name 'wsca*_stderr_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'send_to_sap.*.log.gz' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout.*.gz' -mtime +$2 -exec rm {} \;
	find . -name 'payload.log.*.gz' -mtime +$2 -exec rm {} \;

	find */services/sca/sca.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/sca_sql.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/enotify.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/autoload.log.*.gz -mtime +$2 -exec rm {} \;

	echo =============================
	echo    Delete WSCA5 LOG END
	echo    `date`
	echo =============================
	echo

else
        echo directory $WSCA5_LOG_DIR is not exist
fi

echo ===================================================


if [ -d "$WSCA6_LOG_DIR" ]; then

	echo ============================
	echo    Delete WSCA6 LOG START
	echo    `date`
	echo ============================
	echo

	cd ${WSCA6_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec rm {} \;
	find . -name 'updateCarePacks_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'ManualLinkCarePackRpt_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'payload.log.*' -mtime +$1 -exec rm {} \;
	find */services/sca/ -mtime +$1 -exec rm {} \;

	find . -name 'wsca*_stderr_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'send_to_sap.*.log.gz' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout.*.gz' -mtime +$2 -exec rm {} \;
	find . -name 'payload.log.*.gz' -mtime +$2 -exec rm {} \;

	find */services/sca/sca.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/sca_sql.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/enotify.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/autoload.log.*.gz -mtime +$2 -exec rm {} \;

	echo =============================
	echo    Delete WSCA6 LOG END
	echo    `date`
	echo =============================
	echo

else
        echo directory $WSCA6_LOG_DIR is not exist
fi

echo ===================================================


if [ -d "$WSCA7_LOG_DIR" ]; then

	echo ===========================
	echo    Delete WSCA7 LOG START
	echo    `date`
	echo ===========================
	echo

	cd ${WSCA7_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec rm {} \;
	find . -name 'updateCarePacks_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'ManualLinkCarePackRpt_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'payload.log.*' -mtime +$1 -exec rm {} \;
	find */services/sca/ -mtime +$1 -exec rm {} \;

	find . -name 'wsca*_stderr_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'send_to_sap.*.log.gz' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout.*.gz' -mtime +$2 -exec rm {} \;
	find . -name 'payload.log.*.gz' -mtime +$2 -exec rm {} \;

	find */services/sca/sca.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/sca_sql.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/enotify.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/autoload.log.*.gz -mtime +$2 -exec rm {} \;

	echo ============================
	echo    Delete WSCA7 LOG END
	echo    `date`
	echo ============================
	echo

else
        echo directory $WSCA7_LOG_DIR is not exist
fi

echo ===================================================


if [ -d "$WSCA8_LOG_DIR" ]; then

	echo ===========================
	echo    Delete WSCA8 LOG START
	echo    `date`
	echo ===========================
	echo

	cd ${WSCA8_LOG_DIR}

	find . -name 'send_to_sap.*.log' -mtime +$1 -exec rm {} \;
	find . -name 'updateCarePacks_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'ManualLinkCarePackRpt_*.log' -mtime +$1 -exec rm {} \;
	find . -name 'payload.log.*' -mtime +$1 -exec rm {} \;
	find */services/sca/ -mtime +$1 -exec rm {} \;

	find . -name 'wsca*_stderr_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout_log_*.tar.Z' -mtime +$2 -exec rm {} \;
	find . -name 'send_to_sap.*.log.gz' -mtime +$2 -exec rm {} \;
	find . -name 'wsca*_stdout.*.gz' -mtime +$2 -exec rm {} \;
	find . -name 'payload.log.*.gz' -mtime +$2 -exec rm {} \;

	find */services/sca/sca.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/sca_sql.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/enotify.log.*.gz -mtime +$2 -exec rm {} \;
	find */services/sca/autoload.log.*.gz -mtime +$2 -exec rm {} \;

	echo ========================
	echo    Delete WSCA8 LOG END
	echo    `date`
	echo ========================
	echo
else
        echo directory $WSCA8_LOG_DIR is not exist
fi

echo ===================================================


if [ -d "$WSCA_NON_LOG" ]; then

	echo ===============================
	echo    Delete non log files START
	echo    `date`
	echo ===============================
	echo

	cd ${WSCA_NON_LOG}
	find . -name '*' -mtime +$1 -exec rm {} \;

	echo ==============================
	echo    Delete non log files END
	echo    `date`
	echo ==============================
	echo

else
        echo directory $WSCA_NON_LOG is not exist
fi


echo ===============================Script End===============================

echo ============================
echo    Delete LOGS COMPLETE
echo ============================
