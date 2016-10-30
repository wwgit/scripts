
DROP PROCEDURE IF EXISTS p_T_OPEN_FINAC_ACCT;
DELIMITER //
CREATE PROCEDURE p_T_OPEN_FINAC_ACCT ( IN cnt INT )
BEGIN
	DECLARE i INT DEFAULT 0;
	DECLARE rmain_cnt INT DEFAULT 0;
	DECLARE uid_short BIGINT(20) DEFAULT 0;
	DECLARE uid VARCHAR(200);
	DECLARE user_name VARCHAR(100);
		
	SELECT cnt-COUNT(*) INTO rmain_cnt FROM T_OPEN_FINAC_ACCT;
	SELECT UUID() INTO uid;
	SELECT MAX(ID_OPEN_FINANCACCT) INTO uid_short FROM T_OPEN_FINAC_ACCT;
	
	IF uid_short IS NULL THEN
	   SET uid_short=0;
	END IF;
	
	SET i=0;
	
	WHILE (i<rmain_cnt) 
	DO
		SET uid_short=uid_short+1;
		
		INSERT INTO `T_OPEN_FINAC_ACCT` 
		VALUES (
		uid_short,CONCAT('walter',CAST(uid_short AS CHAR(20))),NULL,NULL,
		NULL,NULL,NULL,NULL,
		'2016-09-18 16:24:04','20160917',0,NULL,
		NULL,NULL,NULL,NULL,
		NULL);
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

DELIMITER ;

SHOW PROCEDURE STATUS WHERE db = 'inetact-test';



