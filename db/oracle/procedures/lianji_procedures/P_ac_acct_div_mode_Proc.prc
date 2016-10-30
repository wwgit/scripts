create or replace procedure P_ac_acct_div_mode_Proc(Count in number) is
 V_FUND_TX_ACCT_NO          VARCHAR2(17);
 V_FUND_ACCT_NO             VARCHAR(12);
 V_COUNT                    NUMBER;
begin
  select Count - count(*) into V_COUNT from lpt5_xm128_trade.ac_acct_div_mode;

  for i in 1.. V_COUNT loop
  
  SELECT substr(SYS_GUID(),5,17) INTO V_FUND_TX_ACCT_NO FROM DUAL;
  SELECT substr(SYS_GUID(),5,12) INTO V_FUND_ACCT_NO FROM DUAL;  
  
  insert into lpt5_xm128_trade.ac_acct_div_mode (FUND_TX_ACCT_NO, FUND_ACCT_NO, FUND_CODE, SHARE_CLASS, DIV_MODE, DIV_RATIO, REG_DT, UD_DT, STIMESTAMP)
  values 
  (V_FUND_TX_ACCT_NO, V_FUND_ACCT_NO, '202102', 'A', '0', 1.00000, '20120814', '20120814', '14-8月 -12 05.42.58.000000 下午');
 -- V_FUND_TX_ACCT_NO:=V_FUND_TX_ACCT_NO+1;
 -- V_FUND_ACCT_NO:=V_FUND_ACCT_NO+1;
  if(mod(i,2000)=0) then
   commit;
  --dbms_output.put_line('已经执行了'||i||'个客户');
  end if;
 end loop;
 commit;
 exception
    when others then
      dbms_output.put_line('exception------');
      DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode);
      DBMS_OUTPUT.put_line('sqlerrm : ' ||sqlerrm);
      rollback;  
end P_ac_acct_div_mode_Proc;
/
