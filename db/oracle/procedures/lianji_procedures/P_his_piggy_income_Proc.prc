create or replace procedure P_his_piggy_income_Proc(Count in number) is
V_DIS_FUND_TX_ACCT_NO       VARCHAR2(32);
V_CUST_BANK_ID              VARCHAR2(32):='200000';
V_COUNT                     NUMBER;
begin
  select count  - count(*) into V_COUNT from lpt5_xm128_trade.his_piggy_income;
  
  for  i in 1..V_COUNT loop
    select substr(SYS_GUID(),0,32) into V_DIS_FUND_TX_ACCT_NO from DUAL;
    insert into lpt5_xm128_trade.his_piggy_income (DIS_FUND_TX_ACCT_NO, CUST_BANK_ID, DIS_CODE, INCOME_DT, LASTDAY_INCOME, UNPAY_INCOME, STIMESTAMP)
    values (V_DIS_FUND_TX_ACCT_NO, V_CUST_BANK_ID, 'HB000A001', '20140504', 0.00021, null, '22-11月-14 12.29.07.000000 上午');
    --V_DIS_FUND_TX_ACCT_NO:=V_DIS_FUND_TX_ACCT_NO+1;
    V_CUST_BANK_ID:=V_CUST_BANK_ID+1;
    if(mod(i,2000)=0) then
      --dbms_output.put_line('已经执行了'||i||'个客户');
      commit;
    end if;
  end loop;
  commit;
end P_his_piggy_income_Proc;
/
