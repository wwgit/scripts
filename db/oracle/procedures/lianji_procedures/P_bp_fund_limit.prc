CREATE OR REPLACE PROCEDURE P_bp_fund_limit(Count in number) IS
 
 -- V_SID                                      number(19);
  v_count                                      number;
  V_LIMIT_ID                                   varchar2(32);
  V_FUND_CODE                                  varchar2(6);
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.bp_fund_limit;
   select max(fund_code) into V_FUND_CODE from lct_xm128_trade.bp_fund_limit;
   V_FUND_CODE:= TO_CHAR(TO_NUMBER(V_FUND_CODE,'999999')+1);
   
   for i in 1 .. v_count loop
     
   select substr(SYS_GUID(),2,32) into V_LIMIT_ID from DUAL;
   
  -- dbms_output.put_line('limit id '||V_LIMIT_ID);
   
    insert into lct_xm128_trade.BP_FUND_LIMIT (
     FUND_LIMIT_ID, FUND_CODE, SHARE_CLASS, BUSI_CODE,
     INVST_TYPE, CUST_TYPE, TRADE_MODE, TRADE_UNIT,
     MIN_APP_AMT, MIN_APP_VOL, MIN_SUPPLE_AMT, MIN_SUPPLE_VOL,
     MAX_APP_AMT, MAX_APP_VOL, REC_STAT, CHECK_FLAG,
     CREATOR, MODIFIER, CHECKER, CRE_DT,
     MOD_DT, IMP_BATCH, MAX_SUM_AMT, MAX_SUM_VOL
     )
    values (
     V_LIMIT_ID, V_FUND_CODE, 'A', '020',
     '0', null, null, 0.00000,
     1000.00000, 0.00000, 1000.00000, 0.00000,
     0.00, 0.00, '0', '1',
     '预埋基金', null, null, '20131028',
     null, null, 99999999999.99, null
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
END P_bp_fund_limit;
/
