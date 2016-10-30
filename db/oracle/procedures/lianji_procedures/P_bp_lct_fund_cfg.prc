CREATE OR REPLACE PROCEDURE P_bp_lct_fund_cfg(Count in number) IS
 
  V_SID                                      number(19);
  v_count                                    number;
  V_FUND_CODE                                varchar2(6);
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.bp_lct_fund_cfg;
   select max(SID) into V_SID from lct_xm128_trade.bp_lct_fund_cfg;
   select max(fund_code) into V_FUND_CODE from lct_xm128_trade.bp_lct_fund_cfg;
   
   V_FUND_CODE:= TO_CHAR(TO_NUMBER(V_FUND_CODE,'999999')+1); 
    
    dbms_output.put_line('当前最大sid: '||V_SID);
    V_SID:=V_SID+1;
   
   for i in 1 .. v_count loop
             
    insert into BP_LCT_FUND_CFG (
     SID, FUND_CODE, DIS_CODE, IS_ALLOW,
     CHECK_FLAG, CREATOR, MODIFIER, CHECKER,
     CRE_DT, MOD_DT, STIMESTAMP, UPDATED_STIMESTAMP,
     REC_STAT
     )
    values (
     V_SID, V_FUND_CODE, 'LCT00K001', '1',
     '1', '预埋基金', null, '预埋基金',
     '20151110', null, null, null,
     '0'); 
     
     V_FUND_CODE:= TO_CHAR(TO_NUMBER(V_FUND_CODE,'999999')+1); 
     V_SID:=V_SID+1;    
        
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
END P_bp_lct_fund_cfg;
/
