USE inetact-test;

SELECT * FROM T_MKT_ACTIVITY_CONFIG;

SELECT * FROM T_PUSHDATA_CONFIG;

SELECT * FROM T_SRV_EXEC_REQUEST
WHERE REF_NO IN ();

SELECT * FROM T_MOBILE_BIND_INFO WHERE user_name = 'kh80122439';

SELECT a.`USER_NAME`,a.`MARK`,b.`DONEE_NAME`,b.`SRV_NAME`,b.`SRV_ARGS`,a.`CREATE_TIME`,
       b.`EXEC_RESULT`,b.`STATUS`,b.`EXECUTE_COUNT`
        FROM T_MOBILE_BIND_INFO a LEFT JOIN
	      T_SRV_EXEC_REQUEST b
	      ON a.id_mobile_bind_info = b.`REF_NO`
	      WHERE a.user_name IN ('huaan006') AND
	      a.`CREATE_TIME` LIKE '2016-08-08%' AND
	      a.`MKT_ACTIVITY_CODE`='3750';

SELECT * FROM T_MOBILE_BIND_INFO
WHERE MOBILE = '2ec01d81fa1db97a31c97c50dd3ccc03'
AND MKT_ACTIVITY_CODE='3750' AND ext_data2 = '18900'
	   
SELECT * FROM T_MOBILE_BIND_INFO a LEFT JOIN
	      T_SRV_EXEC_REQUEST b
	      ON a.id_mobile_bind_info = b.`REF_NO`
	      WHERE a.user_name='kh80122439' AND
	      a.`CREATE_TIME` LIKE '2016-08-04%';

SELECT UUID() FROM DUAL;
/*96679792232890370*/

SELECT uuid_short() FROM DUAL;
SELECT RIGHT(uuid_short(),10) FROM DUAL;
SELECT LEFT(uuid_short(),10) FROM DUAL;

SELECT * FROM `T_OPEN_FINAC_ACCT`;

UPDATE T_OPEN_FINAC_ACCT
SET ASSO_USER_NAME=NULL,
	  SOUR_USER_NAME=NULL,
	  TRUE_NAME=NULL,
    TRADE_ACCT=NULL,
	  ID_CARD=NULL,
	  PROC_DATE='20160721',
		`STATUS`='0';


SELECT * FROM T_SRV_EXEC_REQUEST 
WHERE SRV_NAME = ''