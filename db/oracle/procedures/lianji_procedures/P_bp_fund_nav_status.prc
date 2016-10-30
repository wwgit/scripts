CREATE OR REPLACE PROCEDURE P_bp_fund_nav_status(Count in number) IS
 
 -- V_SID                                      number(19);
  v_count                                      number;
  V_FUND_CODE                                  varchar2(6);
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.bp_fund_nav_status;
   select max(fund_code) into V_FUND_CODE from lct_xm128_trade.bp_fund_nav_status;
   V_FUND_CODE:= TO_CHAR(TO_NUMBER(V_FUND_CODE,'999999')+1);
   
   for i in 1 .. v_count loop
     
   --select substr(SYS_GUID(),1,32) into V_FUND_SETTLE_ID from DUAL;
   
   insert into BP_FUND_NAV_STATUS (
   TRADE_DT, FUND_CODE, SHARE_CLASS, NAV,
   FUND_STAT, FUND_TOTAL, FUND_ASSET, SUM_OF_NAV,
   BENEFIT, DAY_INC, YEAR_YIELD, SALE_FEE,
   VALUE_LINE, REC_STAT, CHECK_FLAG, CREATOR,
   MODIFIER, CHECKER, CRE_DT, MOD_DT,
   ALTER_DT, NAV_SET_FLAG, PD_SUBS_STAT, UPDATED_STIMESTAMP
   )
  values (
  '20151126', V_FUND_CODE, 'A', 1.882000,
   '0', 0.00000, 50000000000.00, 1.000000,
   0.00000, 0.00000, 0.00000, 0.00000,
   0.00000, '0', '1', 'system',
   null, null, '20151026', null,
   '20151023', '2', '0', '26-10月-15 01.08.41.244000 上午'
   );
   
   V_FUND_CODE:= TO_CHAR(TO_NUMBER(V_FUND_CODE,'999999')+1);
   
          
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
END P_bp_fund_nav_status;
/
