create or replace procedure P_fund_acct_dtl_Proc(Count in number) is
V_BLOTTER_NO      VARCHAR2(32);
V_COUNT           NUMBER;
begin
  select count  - count(BLOTTER_NO) into V_COUNT from ac_fund_acct_bal_dtl;
  
  for i in 1..V_COUNT loop
    
    select substr(SYS_GUID(),0,32) into V_BLOTTER_NO from DUAL;
    --dbms_output.put_line('V_BLOTTER_NO: '||V_BLOTTER_NO);
    
    insert into ac_fund_acct_bal_dtl (BLOTTER_NO, DIS_CODE, DIS_FUND_TX_ACCT_NO, PROTOCAL_NO, CUST_BANK_ID, FUND_TX_ACCT_NO, FUND_ACCT_NO, FUND_CODE, SHARE_CLASS, SHARE_REG_DT, TA_SERIAL_NO, TA_CODE, ALLOW_REDE_DT, INIT_VOL, AVAIL_VOL, BALANCE_VOL, FRZN_VOL, JUST_FRZN_VOL, DIS_TRANS_SEQ, DIV_DT, REG_DT, CRE_DT, MOD_DT, UD_DT, STIMESTAMP, DIV_EVERY_DT)
    values (V_BLOTTER_NO, 'HB000A001', '3041000026941HB000A001', '10000030043', '4211', '3041000026941', '99F897440794', '519508', 'A', ' ', '99121031304000000015', '99', null, 10.00000, 0.00000, 0.00000, 0.00000, 0.00000, '2012103100064744', null, null, '20121031', '20121114', '20121114', '10-5月 -14 04.24.14.859000 下午', null);
    --V_BLOTTER_NO:=V_BLOTTER_NO+1;
    if(mod(i,2000)=0) then
      --dbms_output.put_line('已经执行了'||i||'个客户');
      commit;
    end if;
  end  loop;
  commit;
end P_fund_acct_dtl_Proc;
/
