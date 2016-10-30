CREATE OR REPLACE PROCEDURE P_HIS_TRADE_DTL(Count in number) IS
 
 V_TRADE_DTL_SNO         VARCHAR(32);
 v_count                number;
 
BEGIN
  
   select Count - count(*) into v_count from LPT2_XM128_HIS.HIS_TRADE_DTL_MORE_90; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop

        select substr(SYS_GUID(),5,32) into V_TRADE_DTL_SNO from DUAL;
        --dbms_output.put_line('guid: '|| V_M_UUID );
        
          insert into HIS_TRADE_DTL_MORE_90 (
          TRADE_DTL_SNO, DEAL_DTL_SNO, DEAL_NO, TRADE_DTL_STAT,
           CUST_NO, CUST_NAME, CUST_BANK_ID, BANK_ACCT,
           APP_DT, APP_TM, APP_AMT, APP_VOL,
           ACK_DT, ACK_TM, ACK_VOL, ACK_AMT,
           DIS_CODE, DIS_FUND_TX_ACCT_NO, LOANING_CHANNEL_ID, LOANING_CHANNEL_TX_ACCT_NO,
           TA_TRADE_DT, TA_PMT_FLAG, TA_COMP_FLAG, TA_COMP_DT,
           TA_DEAL_NO, TA_BANK_CODE, ACK_CODE, ACK_MSG,
           RET_CODE, RET_MSG, BUSI_CODE, FUND_CODE,
           FUND_TX_ACCT_NO, ICBC_DEAL_ACCT_NO, CREATOR, MODIFIER,
           CHECKER, CRE_DT, MOD_DT, STIMESTAMP,
           UPDATED_STIMESTAMP)
          values (
          V_TRADE_DTL_SNO, '31201503010012576390000008083', '31201503010012575850000080094', '01',
           '1008751877', '杨大大', '762322', '6225880218884411',
           '20150301', '100000', 5000000.00, 0.00,
           '20150301', '001708', 5000000.00000, 5000000.00000,
           'AON00H001', '3041008810591AON00H001', null, null,
           '20150301', '00', '00', null,
           '20150615000002789', null, '0000000', '交易成功',
           null, null, '022', '000677',
           '3041008810591', '20150605000001544', 'bobo', 'linbo',
           'linbo', '20150301', '20150301', null,
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
      
END P_HIS_TRADE_DTL;
/
