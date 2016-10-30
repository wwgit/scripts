
DROP PROCEDURE IF EXISTS INETACT.p_proc_trail;
DELIMITER //
CREATE PROCEDURE INETACT.p_proc_trail( IN cnt INT, OUT o_result INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	DECLARE rmain_cnt INT DEFAULT 0;
	DECLARE uid_short INT DEFAULT 0;
		
	SELECT cnt-COUNT(*) INTO rmain_cnt FROM INETACT.T_MOBILE_BIND_INFO;
	
	SET i=0;
	
	WHILE (i<rmain_cnt) 
	DO
		
		#select uuid_short() from dual;
		
		/*INSERT INTO INETACT.`T_MOBILE_BIND_INFO` (
		`ID_MOBILE_BIND_INFO`, `USER_NAME`, `USER_ID`, `MOBILE`,
		 `MOBILE_SYM`, `OSN`, `ISN`, `MARK`,
		 `CHANNEL`, `SOURCE_NO`, `MKT_ACTIVITY_CODE`, `REMARK`,
		 `URL_CODE`, `CREATE_TIME`, `DONE_STATUS`
		 ) VALUES(
		 '-9999689049872','dzh-crp-sms',NULL,'872a07a4e0035012624dee6174e9bcb7',
		 'KmPCFO5nkhIn9FcMaXZZAQ..',NULL,NULL,'1820****126',
		 'Web','5','3707','{\'verifyCode\':\'998070\',\'verifyType\':\'短信验证\'}',
		 'common_bind','2015-09-18 09:11:32',NULL
		 
		 );*/
		SET i=i+1;
		IF MOD(i,2000)=0 THEN
			SELECT i,rmain_cnt;
		END IF;	
		#SELECT i from dual;
	END WHILE;
	#select rmain_cnt,i;
END;//
DELIMITER;



