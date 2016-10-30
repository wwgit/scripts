CREATE OR REPLACE PROCEDURE P_tp_deal_dtl(Count in number) IS
 
 V_DEAL_DTL_SNO         VARCHAR(32);
 v_count                number;
 
BEGIN
  
   select Count - count(*) into v_count from LPT2_XM128_DEAL.tp_deal_dtl; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop

        select substr(SYS_GUID(),5,32) into V_DEAL_DTL_SNO from DUAL;
        --dbms_output.put_line('guid: '|| V_M_UUID );
        
       insert into TP_DEAL_DTL (
          DEAL_DTL_SNO, DEAL_NO, BANK_CODE, CUST_BANK_ID,
          BANK_ACCT, PD_TRADE_DT, PMT_DTM, APP_AMT,
          APP_VOL, ACK_VOL, ACK_AMT, TX_PMT_FLAG,
          TX_COMP_FLAG, DEAL_DTL_STAT, LOANING_CHANNEL_ID, UNUSUAL_TRANS_TYPE,
          PMT_DEAL_NO, PMT_INST_CODE, PMT_MODE, RET_CODE,
          RET_MSG, PMT_RET_CODE, PMT_RET_MSG, PEOPLE_PROC_FLAG,
          PROC_FLAG, MEMO, CREATOR, MODIFIER,
          CHECKER, CRE_DT, MOD_DT, STIMESTAMP,
          UPDATED_STIMESTAMP
          )
      values (
        V_DEAL_DTL_SNO, '31201504280655383540000000074', '308', '761400',
        '1234567890000000031', '20150429', '28-4月 -15 06.55.39.483000 下午', 1000.99,
        0.00, 0.00000, 0.00000, '04',
        '01', '02', null, null,
        null, '1006', '04', null,
        null, '0', '支付状态:04,异常信息:null', null,
        '01', null, 'web', null,
        null, '20150428', null, '28-4月 -15 06.55.38.322000 下午',
        null);
      
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
END P_tp_deal_dtl;
/
