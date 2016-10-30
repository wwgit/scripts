create or replace procedure P_dis_trade_plan_Proc(Count in number) is
V_DIS_FUND_TX_ACCT_NO       VARCHAR2(32);
V_PROTOCAL_NO               VARCHAR2(12):='30010874730';
V_COUNT                     NUMBER;
begin
  SELECT COUNT - COUNT(*) INTO V_COUNT FROM lct_xm128_trade.ac_dis_acct_trade_plan;
  FOR i IN 1..V_COUNT LOOP
    select substr(SYS_GUID(),0,32) into V_DIS_FUND_TX_ACCT_NO from DUAL;
    insert into lct_xm128_trade.ac_dis_acct_trade_plan (DIS_CODE, DIS_FUND_TX_ACCT_NO, PROTOCAL_NO, PROTOCAL_TYPE, CUST_NO, FUND_TX_ACCT_NO, STIMESTAMP)
    values ('HB000A001', V_DIS_FUND_TX_ACCT_NO, V_PROTOCAL_NO, '1', '1000020047', '3041000023049', '09-10月-12 04.38.48.653000 下午');
   -- V_DIS_FUND_TX_ACCT_NO:=V_DIS_FUND_TX_ACCT_NO+1;
   -- V_PROTOCAL_NO:=V_PROTOCAL_NO+1;
    IF(MOD(i,2000)=0) THEN
      --dbms_output.put_line('已经执行了'||i||'个客户');
      COMMIT;
    END IF;
   END LOOP;
   COMMIT; 
end P_dis_trade_plan_Proc;
/
