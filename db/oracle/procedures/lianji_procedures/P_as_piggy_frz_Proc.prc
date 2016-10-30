create or replace procedure P_as_piggy_frz_Proc(Count in number) is
V_DIS_FUND_TX_ACCT_NO       VARCHAR2(32);
V_CUST_BANK_ID              VARCHAR2(32):='100000';
V_COUNT                     NUMBER;
begin
  select count  - count(DIS_FUND_TX_ACCT_NO) into V_COUNT from lpt5_xm128_trade.as_piggy_frz;
  
   for i in 1..V_COUNT loop
    select substr(SYS_GUID(),0,32) into V_DIS_FUND_TX_ACCT_NO from DUAL;
    insert into lpt5_xm128_trade.as_piggy_frz (DIS_FUND_TX_ACCT_NO, CUST_BANK_ID, TRADE_DT, APP_DT, DIS_CODE, FUND_TX_ACCT_NO, REDE_UNACK_AMT, FAST_FRZN_AMT, DEPOSIT_UNACK_AMT, DO_FRZN_STAT, STIMESTAMP, FAST_REDE_COUNT)
    values (V_DIS_FUND_TX_ACCT_NO, '447443', '20141121', '20141121', 'HB000A001', '3041006706313', 0.00000, 0.00000, 100.00000, '1', '21-11月-14 11.56.11.510000 上午', 0);
   -- V_DIS_FUND_TX_ACCT_NO:=V_DIS_FUND_TX_ACCT_NO+1;
    V_CUST_BANK_ID:=V_CUST_BANK_ID+1;
    if(mod(i,2000)=0) then
      --dbms_output.put_line('已经执行了'||i||'个客户');
      commit;
    end if;
  end  loop;
  commit;
end P_as_piggy_frz_Proc;
/
