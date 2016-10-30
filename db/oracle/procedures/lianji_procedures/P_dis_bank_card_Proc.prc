create or replace procedure P_dis_bank_card_Proc(Count in number) is
V_DIS_FUND_TX_ACCT_NO       VARCHAR2(32);
V_CUST_BANK_ID              VARCHAR2(32):='100000';
V_COUNT                     NUMBER;
begin
  SELECT COUNT - COUNT(DIS_FUND_TX_ACCT_NO) INTO V_COUNT FROM ac_dis_bank_card;
    
    FOR i IN 1..V_COUNT LOOP
      select substr(SYS_GUID(),0,32) into V_DIS_FUND_TX_ACCT_NO from DUAL;
      insert into ac_dis_bank_card (DIS_FUND_TX_ACCT_NO, DIS_CODE, CUST_NO, FUND_TX_ACCT_NO, CUST_BANK_ID, IS_VALID, CREATOR, MODIFIER, CRE_DT, MOD_DT, STIMESTAMP, PAY_SIGN, UPDATED_STIMESTAMP, PAY_SIGN_DT, BANK_CARD_CANCEL_DT)
      values (V_DIS_FUND_TX_ACCT_NO, 'HB000A001', '1000026841', '3041000030418', V_CUST_BANK_ID, '1', 'web', 'web', '20121118', '20121118', '28-12月-13 12.52.50.000000 上午', '1', '04-9月 -14 06.42.12.000000 下午', null, null);
      IF(MOD(i,2000)=0) THEN
       COMMIT;
       --dbms_output.put_line('已经执行了'||i||'个客户');
      END IF;
  END LOOP;
  COMMIT;
end P_dis_bank_card_Proc;
/
