CREATE OR REPLACE PROCEDURE P_bp_ta_info(Count in number) IS
 
  --V_SID                                      number(19);
  v_count                                    number;
  V_TA_CODE                                  varchar2(6);
 
BEGIN
  
   select Count - count(*) into v_count from lpt8_xm128_trade.bp_ta_info;
   --select max(SID) into V_SID from lpt8_xm128_trade.bp_fund_share_class;
   select max(ta_code) into V_TA_CODE from lpt8_xm128_trade.bp_ta_info;
  
   dbms_output.put_line('当前最大ta code: '||V_TA_CODE); 
   
   V_TA_CODE:= TO_CHAR(TO_NUMBER(V_TA_CODE,'99')+1); 
   
   for i in 1 .. v_count loop
     
   insert into BP_TA_INFO (
     TA_CODE, TA_NAME, TA_ABBR, TA_STAT,
     CUST_INFO_TYPE_ID, REC_STAT, CHECK_FLAG, CREATOR,
     CHECKER, MODIFIER, CRE_DT, MOD_DT,
     MARGIN_PMT_FLAG, PART_CODE, DFLT_CHK_MODE_05, DFLT_CHK_MODE_26,
     BAL_DTL_26_DEAL_FLAG
     )
    values (
     V_TA_CODE,'预埋基金', '预埋基金', '0',
     '0001', '0', '1', 'may.tang',
     'david.chen', null, '20120514', null,
     null, null, '2', '1',
     '3'
     );        
     
     V_TA_CODE:= TO_CHAR(TO_NUMBER(V_TA_CODE,'99')+1);     
        
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
END P_bp_ta_info;
/
