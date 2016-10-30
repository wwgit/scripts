create or replace procedure P_ac_fund_tx_acct_Proc(Count in number) is

V_CUST_NO                   VARCHAR2(10);
V_FUND_TX_ACCT_NO           VARCHAR2(17);
V_COUNT                     NUMBER;

begin
  SELECT COUNT - COUNT(*) INTO V_COUNT FROM lct_xm128_trade.ac_fund_tx_acct;
  FOR i IN 1..V_COUNT LOOP
    select substr(SYS_GUID(),5,10) into V_CUST_NO from DUAL;
    select substr(SYS_GUID(),5,17) into V_FUND_TX_ACCT_NO from DUAL;
    
    insert into lct_xm128_trade.ac_fund_tx_acct (CUST_NO, FUND_TX_ACCT_NO, FUND_TX_ACCT_STAT, REG_DT,
     UD_DT, CAN_DT, STIMESTAMP, UPDATED_STIMESTAMP)
    values (V_CUST_NO, V_FUND_TX_ACCT_NO, '0', '20120510',
     null, null, '26-11月 -12 03.16.52.341000 下午', '04-9月 -14 06.46.06.000000 下午');
    
   -- V_DIS_FUND_TX_ACCT_NO:=V_DIS_FUND_TX_ACCT_NO+1;
   -- V_PROTOCAL_NO:=V_PROTOCAL_NO+1;
    IF(MOD(i,2000)=0) THEN
      --dbms_output.put_line('已经执行了'||i||'个客户');
      COMMIT;
    END IF;
   END LOOP;
   COMMIT; 
end P_ac_fund_tx_acct_Proc;
/
