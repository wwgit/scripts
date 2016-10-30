
DROP PROCEDURE IF EXISTS test.p_proc_trail;
DELIMITER //
CREATE PROCEDURE test.p_proc_trail( IN cnt INT )
BEGIN
	DECLARE i INT DEFAULT 0;
	DECLARE rmain_cnt INT DEFAULT 0;
	DECLARE uid_short BIGINT(20) DEFAULT 0;
	DECLARE uid VARCHAR(200);
	DECLARE user_name VARCHAR(50);
		
	SELECT cnt-COUNT(*) INTO rmain_cnt FROM test.user_info;
	SELECT UUID() INTO uid;
	SELECT MAX(ID_MOBILE_BIND_INFO) INTO uid_short FROM test.user_info;
	
	IF uid_short IS NULL THEN
	   SET uid_short=0;
	END IF;
	
	SET i=0;
	
	WHILE (i<rmain_cnt) 
	DO
		SET uid_short=uid_short+1;
		
		INSERT INTO test.`user_info` (
		 `ID_MOBILE_BIND_INFO`, `USER_NAME`, `USER_ID`, `MOBILE`,
		 `MOBILE_SYM`, `OSN`, `ISN`, `MARK`,
		 `CHANNEL`, `SOURCE_NO`, `MKT_ACTIVITY_CODE`, `REMARK`,
		 `URL_CODE`, `CREATE_TIME`
		 ) 
		 VALUES(
		   uid_short,CONCAT('walter',CAST(uid_short AS CHAR(20))),
		   NULL,CONCAT(uid,i),
	           'KmPCFO5nkhIn9FcMaXZZAQ..',NULL,NULL,'1820****126',
		   'Web','5','3707','{\'verifyCode\':\'998070\',\'verifyType\':\'短信验证\'}',
		   'common_bind','2016-07-19 09:11:32'	 
		 );
		SET i=i+1;
		IF MOD(i,2000)=0 THEN
			SELECT i,rmain_cnt;
			COMMIT;
		END IF;	
		#SELECT i from dual;
	END WHILE;
	COMMIT;
	#select rmain_cnt,i;
END;//

DELIMITER;



