CREATE OR REPLACE PROCEDURE P_his_trade_dtl_more_90(Count in number) IS
 
 V_TRADE_DTL_SNO   VARCHAR(32);
 v_count           number;
 
BEGIN
  
   select Count - count(*) into v_count from LPT2_XM128_DEAL.his_trade_dtl_more_90; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop

        select substr(SYS_GUID(),5,32) into V_TRADE_DTL_SNO from DUAL;
        --dbms_output.put_line('guid: '|| V_M_UUID );
        
    insert into his_trade_dtl_more_90 (
        TRADE_DTL_SNO, DEAL_DTL_SNO, DEAL_NO, 
        TRADE_DTL_STAT, CUST_NO, CUST_NAME, CUST_BANK_ID,
         BANK_ACCT, APP_DT, APP_TM, APP_AMT,
         APP_VOL, ACK_DT, ACK_TM, ACK_VOL,
         ACK_AMT, DIS_CODE, DIS_FUND_TX_ACCT_NO, LOANING_CHANNEL_ID,
         LOANING_CHANNEL_TX_ACCT_NO, TA_TRADE_DT, TA_PMT_FLAG,
         TA_COMP_FLAG, TA_COMP_DT, TA_DEAL_NO, TA_BANK_CODE,
         ACK_CODE, ACK_MSG, RET_CODE, RET_MSG,
         BUSI_CODE, FUND_CODE, FUND_TX_ACCT_NO, ICBC_DEAL_ACCT_NO,
         CREATOR, MODIFIER, CHECKER, CRE_DT,
         MOD_DT, STIMESTAMP, UPDATED_STIMESTAMP
        )
        values (
          V_TRADE_DTL_SNO, '31201504280655384530000000053', '31201504280655383540000000074',
           '03', '1008749403', '尾三一', '761400',
           '1234567890000000031', '20150428', '185538', 1000.99,
           0.00, null, null, 0.00000,
           0.00000, 'HB000A001', '3041008808127HB000A001', null,
           null, '20150429', '00',
           '00', null, null, null, 
           null,null, null, null,
           '022', '000677', '3041008808127', '20150428000000010',
           'web',null, null, '20150428',
           null, '3-2月 -15 06.55.38.322000 下午', null
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
END P_his_trade_dtl_more_90;
/
