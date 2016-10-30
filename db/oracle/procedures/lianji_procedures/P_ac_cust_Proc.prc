create or replace procedure P_ac_cust_Proc(Count in number) is

V_CUST_NO                   VARCHAR2(10);
V_ID_NO                     VARCHAR2(32);
V_COUNT                     NUMBER;

begin
  SELECT COUNT - COUNT(*) INTO V_COUNT FROM lct_xm128_trade.ac_cust;
  FOR i IN 1..V_COUNT LOOP
    select substr(SYS_GUID(),5,10) into V_CUST_NO from DUAL;
    select substr(SYS_GUID(),0,32) into V_ID_NO from DUAL;
   -- V_CUST_BANK_ID := V_DIS_FUND_TX_ACCT_NO;
    
    insert into lct_xm128_trade.ac_cust (CUST_NO, INVST_TYPE, ID_TYPE, ID_NO,
     CUST_NAME, CUST_STAT, CORP_ID_TYPE, CORP_ID_NO,
     CORPORATION, BIRTHDAY, GENDER, REG_DT,
     UD_DT, CAN_DT, STIMESTAMP, ID_VALIDITY_START,
     ID_VALIDITY_END, ID_ALWAYS_VALID_FLAG, ID_VRFY_STAT, CORP_ID_ALWAYS_VALID_FLAG,
     CORP_ID_VALIDITY_END, REG_OUTLET_CODE, REG_TRADE_CHAN, REG_DIS_CODE,
     UPDATED_STIMESTAMP, VIP_FLAG)
    values (V_CUST_NO, '1', '0', V_ID_NO,
     '薛00180', '0', null, null,
     null, '19880603', '1', '20120510',
     '20140611', null, null, null,
     null, null, null, null,
     null, null, null, 'HB000A001',
     '04-9月 -14 06.43.06.000000 下午', null);
    
   -- V_DIS_FUND_TX_ACCT_NO:=V_DIS_FUND_TX_ACCT_NO+1;
   -- V_PROTOCAL_NO:=V_PROTOCAL_NO+1;
    IF(MOD(i,2000)=0) THEN
      --dbms_output.put_line('已经执行了'||i||'个客户');
      COMMIT;
    END IF;
   END LOOP;
   COMMIT; 
end P_ac_cust_Proc;
/
