create or replace procedure P_ac_dis_bank_card_Proc(Count in number) is

V_DIS_FUND_TX_ACCT_NO               VARCHAR2(32);
V_CUST_BANK_ID                      VARCHAR2(32);
V_COUNT                             NUMBER;

begin
  
  SELECT COUNT - COUNT(*) INTO V_COUNT FROM lct_xm128_trade.ac_dis_bank_card;
  select max(cust_bank_id) into V_CUST_BANK_ID from ac_dis_bank_card;
  V_CUST_BANK_ID := V_CUST_BANK_ID+1;
  
  FOR i IN 1..V_COUNT LOOP
    
    select substr(SYS_GUID(),0,32) into V_DIS_FUND_TX_ACCT_NO from DUAL;
    
    insert into lct_xm128_trade.ac_dis_bank_card (DIS_FUND_TX_ACCT_NO, DIS_CODE, CUST_NO, FUND_TX_ACCT_NO,
     CUST_BANK_ID, IS_VALID, CREATOR, MODIFIER,
     CRE_DT, MOD_DT, STIMESTAMP, PAY_SIGN,
     UPDATED_STIMESTAMP, PAY_SIGN_DT, BANK_CARD_CANCEL_DT)
    values (V_DIS_FUND_TX_ACCT_NO, 'YYLC0B001', '1000932702', '3041000949552',
     V_CUST_BANK_ID, '1', 'HD0001', null,
     '20131228', null, '28-12月-13 11.15.00.080000 上午', '2', 
     '04-9月 -14 06.42.12.000000 下午', null, null);
     
     V_CUST_BANK_ID := V_CUST_BANK_ID+1;
    
    IF(MOD(i,2000)=0) THEN
      --dbms_output.put_line('已经执行了'||i||'个客户');
      COMMIT;
    END IF;
   END LOOP;
   COMMIT; 
end P_ac_dis_bank_card_Proc;
/
