create or replace procedure P_ac_dis_cust_Proc(Count in number) is

V_DIS_CUST_ID               VARCHAR2(32);
--V_ID_NO                     VARCHAR2(32);
V_COUNT                     NUMBER;

begin
  SELECT COUNT - COUNT(*) INTO V_COUNT FROM lct_xm128_trade.ac_dis_cust;
  FOR i IN 1..V_COUNT LOOP
    select substr(SYS_GUID(),0,32) into V_DIS_CUST_ID from DUAL;
   -- select substr(SYS_GUID(),0,32) into V_ID_NO from DUAL;
   -- V_CUST_BANK_ID := V_DIS_FUND_TX_ACCT_NO;
    
    insert into lct_xm128_trade.ac_dis_cust (DIS_CUST_ID, CUST_NO, CUST_ABBR, POST_CODE,
     ADDR, TEL_NO, LINK_MAN, LINK_ID_TYPE,
     LINK_ID_NO, LINK_METHOD, LINK_TEL, CUST_TYPE,
     PAGER_NO, EMAIL, FAX, FAX_FLAG,
     HOME_TEL_NO, OFFICE_TEL_NO, MOBILE, EDU_LEVEL,
     VOCATION, INC_LEVEL, FUND_MAN_DLVY_MODE, AGENT_DLVY_MODE,
     CONF_DOC_NO, SECU_SH_ACCT_NO, SECU_SZ_ACCT_NO, MINOR_FLAG,
     MINOR_ID, CORP_CODE, CONS_CODE, UD_DT, STIMESTAMP,
     CUST_RISK_LEVEL, PROV_CODE, CITY_CODE, COMPANY,
     CUST_LOGIN_PASSWD, CUST_TX_PASSWD, SELF_MSG, SMS_REMIND_OPTION,
     EMAIL_REMIND_OPTION, ACTIVE_STAT, NATIONALITY, AGENT_DLVY_TYPE,
     FUND_MAN_DLVY_TYPE, MARRIAGE_STAT, SECU_INVEST_EXP, REG_ADDR,
     REG_POST_CODE, RISK_SURVEY_DT, LAST_RISK_LEVEL_BY_SELF, CUST_LOGIN_PASSWD_TYPE,
     CUST_TX_PASSWD_TYPE, UPDATED_STIMESTAMP, CORP_CUST_RISK_LEVEL, MOBILE_VRFY_STAT,
     MOBILE_VRFY_STIMESTAMP)
    values (V_DIS_CUST_ID, '1000684885', null, null,
     null, null, null, null,
     null, null, null, null,
     null, null, null, null,
     null, null, '***', null, 
     null, null, null, '0', null, null,
     null, null, null, null,
     null, null, '03-12月-13 03.12.19.600000 下午', '1', 
     null, null, null, null,
     null, '吴智慧', '11111111111111111111111111111111', '11111111111111111111111111111111', 
     '1', null, '3', null,
     null, null, null, null,
     '20131203', null, '0', '0',
     '04-9月 -14 06.42.46.000000 下午', null, '1', null);
    
   -- V_DIS_FUND_TX_ACCT_NO:=V_DIS_FUND_TX_ACCT_NO+1;
   -- V_PROTOCAL_NO:=V_PROTOCAL_NO+1;
    IF(MOD(i,2000)=0) THEN
      --dbms_output.put_line('已经执行了'||i||'个客户');
      COMMIT;
    END IF;
   END LOOP;
   COMMIT; 
end P_ac_dis_cust_Proc;
/
