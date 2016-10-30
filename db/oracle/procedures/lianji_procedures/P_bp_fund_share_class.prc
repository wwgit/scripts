CREATE OR REPLACE PROCEDURE P_bp_fund_share_class(Count in number) IS
 
  --V_SID                                      number(19);
  v_count                                    number;
  V_FUND_CODE                                varchar2(6);
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.bp_fund_share_class;
   --select max(SID) into V_SID from lpt8_xm128_trade.bp_fund_share_class;
   select max(fund_code) into V_FUND_CODE from lct_xm128_trade.bp_fund_share_class;
  
   dbms_output.put_line('当前最大fund code: '||V_FUND_CODE); 
   
   V_FUND_CODE:= TO_CHAR(TO_NUMBER(V_FUND_CODE,'999999')+1); 
   
   for i in 1 .. v_count loop
             
    insert into  lct_xm128_trade.BP_FUND_SHARE_CLASS (
     FUND_CODE, SHARE_CLASS, SHARE_CODE, SHARE_DESC,
     SHARE_STAT, REC_STAT, CHECK_FLAG, CREATOR,
     MODIFIER, CHECKER, CRE_DT, MOD_DT
     )
    values (
     V_FUND_CODE, 'A', '1', null, 
     '0','0', '1', '预埋基金', 
     null,'预埋基金', '20130428', null);
     
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
END P_bp_fund_share_class;
/
