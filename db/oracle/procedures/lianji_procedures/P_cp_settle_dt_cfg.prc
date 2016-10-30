CREATE OR REPLACE PROCEDURE P_cp_settle_dt_cfg(Count in number) IS
 
 -- V_SID                                      number(19);
  v_count                                       number;
  V_FUND_SETTLE_ID                              varchar2(32);
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.cp_settle_dt_cfg;
   
   for i in 1 .. v_count loop
     
   select substr(SYS_GUID(),1,32) into V_FUND_SETTLE_ID from DUAL;
     
   insert into CP_SETTLE_DT_CFG (
     SETTLE_DT_CFG_ID, TA_CODE, FUND_CODE, SHARE_CLASS,
     BUSI_CODE, ACK_RSLT, BUSI_TYPE, SETTLE_DAYS,
     SETTLE_DT, MEMO, REC_STAT, CREATOR,
     MODIFIER, CHECKER, CHECK_FLAG, CRE_DT,
     MOD_DT, SETTLE_DT_TYPE, SETTLE_DT_FREQ, FUND_MAN_CODE,
     PART_CODE
     )
    values (
    V_FUND_SETTLE_ID, null, '164207', null,
     '120', '1', '04', '0',
     null, null, '0', '预埋基金',
     null, '预埋基金', '1', '20120823',
     null, '1', null, '***',
     'TA98'
     );           
        
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
END P_cp_settle_dt_cfg;
/
