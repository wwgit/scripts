CREATE OR REPLACE PROCEDURE P_ac_fund_acct(Count in number) IS
 
 -- V_SID                                      number(19);
  v_count                                      number;
  V_FUND_ACCT                                  varchar2(12);
  V_FUND_TX_ACCT_NO                            varchar2(17);
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.ac_fund_acct;
   --select max(fund_code) into V_FUND_CODE from lpt8_xm128_trade.ac_fund_acct;
   --V_FUND_CODE:= TO_CHAR(TO_NUMBER(V_FUND_CODE,'999999')+1);
   
   for i in 1 .. v_count loop
     
   select substr(SYS_GUID(),4,12) into V_FUND_ACCT from DUAL;
   select substr(SYS_GUID(),4,17) into V_FUND_TX_ACCT_NO from DUAL;
   
   insert into AC_FUND_ACCT (
     FUND_ACCT_NO, FUND_TX_ACCT_NO, TA_CODE, FUND_ACCT_STAT,
     REG_DT, UD_DT, CAN_DT, STIMESTAMP, UPDATED_STIMESTAMP
     )
    values (
    V_FUND_ACCT, V_FUND_TX_ACCT_NO, '48', '0',
     '20151021', '20151023', null, '25-11月-15 04.43.04.000000 上午',
     '25-11月-15 10.46.37.000000 下午');
   
   
  -- dbms_output.put_line('limit id '||V_LIMIT_ID);
   
    -- V_FUND_CODE:= TO_CHAR(TO_NUMBER(V_FUND_CODE,'999999')+1);
          
      if (mod(i, 2000) = 0) then
          --dbms_output.put_line('已经执行了'||i||'个客户');
          commit;
      end if;
   end loop;
   commit;

exception
    when others then
      dbms_output.put_line('exception------');
      DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode);
      DBMS_OUTPUT.put_line('sqlerrm : ' ||sqlerrm);
      rollback;
END P_ac_fund_acct;
/
