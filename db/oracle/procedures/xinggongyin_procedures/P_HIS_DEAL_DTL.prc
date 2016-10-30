CREATE OR REPLACE PROCEDURE P_HIS_DEAL_DTL(Count in number) IS
 
 V_DEAL_DTL_SNO         VARCHAR(32);
 v_count                number;
 
BEGIN
  
   select Count - count(*) into v_count from LPT2_XM128_HIS.HIS_DEAL_DTL_MORE_90; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop

        select substr(SYS_GUID(),5,32) into V_DEAL_DTL_SNO from DUAL;
        --dbms_output.put_line('guid: '|| V_M_UUID );
        
        insert into HIS_DEAL_DTL_MORE_90 (
         DEAL_DTL_SNO, DEAL_NO, BANK_CODE, CUST_BANK_ID,
         BANK_ACCT, PD_TRADE_DT, PMT_DTM, APP_AMT,
         APP_VOL, ACK_VOL, ACK_AMT, TX_PMT_FLAG,
         TX_COMP_FLAG, DEAL_DTL_STAT, LOANING_CHANNEL_ID, UNUSUAL_TRANS_TYPE,
         PMT_DEAL_NO, PMT_INST_CODE, PMT_MODE, RET_CODE,
         RET_MSG, PMT_RET_CODE, PMT_RET_MSG, PEOPLE_PROC_FLAG,
         PROC_FLAG, MEMO, CREATOR, MODIFIER,
         CHECKER, CRE_DT, MOD_DT, STIMESTAMP,
         UPDATED_STIMESTAMP, ARRIVE_DT
         )
        values (
        V_DEAL_DTL_SNO, '31201503010012575850000080094', '308', '762322',
         '6225880218884411', '20150301', null, 5000000.00,
         0.00, 5000000.00000, 5000000.00000, '02',
         '00', '01', null, null,
         null, null, '01', null,
         null, null, null, null,
         '02', null, 'bobo', 'linbo',
         'stresstest', '20150301', '20150301', null,
         '26-6月 -15 07.48.25.000000 下午', null
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
      
END P_HIS_DEAL_DTL;
/
