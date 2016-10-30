CREATE OR REPLACE PROCEDURE P_bp_fund_tx_open_cfg(Count in number) IS
 
 -- V_SID                                      number(19);
  v_count                                    number;
  V_FUND_CFG_ID                              varchar2(32);
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.bp_fund_tx_open_cfg;
   
   for i in 1 .. v_count loop
     
   select substr(SYS_GUID(),1,32) into V_FUND_CFG_ID from DUAL;
             
    insert into lct_xm128_trade.BP_FUND_TX_OPEN_CFG (
     FUND_TX_OPEN_CFG_ID, TA_CODE, FUND_CODE, TX_CODE,
     OPEN_FLAG, REC_STAT, CHECK_FLAG, CREATOR,
     MODIFIER, CHECKER, CRE_DT, MOD_DT,
     IMP_BATCH
     )
    values (
    V_FUND_CFG_ID, '48', '482002', '209013',
     '1', '0', '1', '预埋基金',
     null, '预埋基金', '20140429', null,
     null);
     
     --V_FUND_CODE:= TO_CHAR(TO_NUMBER(V_FUND_CODE,'999999')+1); 
     --V_SID:=V_SID+1;    
        
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
END P_bp_fund_tx_open_cfg;
/
