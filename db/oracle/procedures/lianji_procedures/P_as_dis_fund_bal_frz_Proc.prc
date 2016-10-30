create or replace procedure P_as_dis_fund_bal_frz_Proc(Count in number) is

V_DIS_FUND_TX_ACCT_NO               VARCHAR2(32);
--V_CUST_BANK_ID                      VARCHAR2(32);
V_COUNT                             NUMBER;

begin
  
  SELECT COUNT - COUNT(*) INTO V_COUNT FROM lct_xm128_trade.as_dis_fund_bal_frz;
  --select max(cust_bank_id) into V_CUST_BANK_ID from as_dis_fund_bal_frz;
  --V_CUST_BANK_ID := V_CUST_BANK_ID+1;
  
  FOR i IN 1..V_COUNT LOOP
    
    select substr(SYS_GUID(),0,32) into V_DIS_FUND_TX_ACCT_NO from DUAL;
    
    insert into lct_xm128_trade.as_dis_fund_bal_frz (
      DIS_FUND_TX_ACCT_NO, DIS_CODE, PROTOCAL_NO, TA_TRADE_DT,
      FUND_TX_ACCT_NO, FUND_ACCT_NO, FUND_CODE, SHARE_CLASS,
      TODAY_FRZN_VOL, STIMESTAMP, CUST_BANK_ID
      )
    values (
     V_DIS_FUND_TX_ACCT_NO, 'HB000A001', '10000673030', '20150105',
     '3041005898628', '481325094892', '482002', 'A',
     933.81000, '05-1月 -15 02.08.46.181000 下午', '401125');
     
     --V_CUST_BANK_ID := V_CUST_BANK_ID+1;
    
    IF(MOD(i,2000)=0) THEN
      --dbms_output.put_line('已经执行了'||i||'个客户');
      COMMIT;
    END IF;
   END LOOP;
   COMMIT; 
end P_as_dis_fund_bal_frz_Proc;
/
