CREATE OR REPLACE PROCEDURE P_his_deal_more_90(Count in number) IS
 
 V_DEAL_NO         VARCHAR(32);
 v_count           number;
 
BEGIN
  
   select Count - count(*) into v_count from LPT2_XM128_DEAL.his_deal_more_90; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop

        select substr(SYS_GUID(),5,32) into V_DEAL_NO from DUAL;
        --dbms_output.put_line('guid: '|| V_M_UUID );
        
        insert into his_deal_more_90 (
          DEAL_NO, TX_CODE, DEAL_TYPE, DEAL_STAT,
          VOL_OK, CUST_NO, CUST_NAME, CUST_BANK_ID,
          ID_TYPE, ID_NO, BANK_ACCT, BANK_CODE,
          PRODUCT_CODE, PRODUCT_NAME, APP_DT, APP_TM,
          APP_AMT, APP_VOL, SYS_TRADE_DT, PD_TRADE_DT,
          INVST_TYPE, TRADE_CHAN, OUTLET_CODE, CONS_CODE,
          TRANSACTOR, TRANSACTOR_ID_TYPE, TRANSACTOR_ID_NO, DIS_CODE,
          DIS_FUND_TX_ACCT_NO, PROTOCAL_NO, TX_IP, CORP_DEAL_NO,
          PIGGY_PAY_DEAL_NO, PIGGY_PAY_PNO, PIGGY_PAY_PNM, PIGGY_PAY_PTP,
          RET_CODE, RET_MSG, ACTIVE_TYPE, ACTIVE_NAME,
          MEMO, CREATOR, MODIFIER, CHECKER,
          CRE_DT, MOD_DT, CHECK_FLAG, STIMESTAMP,
          UPDATED_STIMESTAMP
          )
        values (
          V_DEAL_NO, '319011', null, '02',
          '00', '1008749403', '尾三一', '761400',
          '0', '451301198001010053', '1234567890000000031', '308',
          '000677', null, '20150428', '185538',
          1000.99, 0.00, '20150428', '20150429',
          '1', '2', 'WEB000001', null,
          null, null, null, 'HB000A001',
          '3041008808127HB000A001', null, '192.168.121.97', null,
          null, null, null, null,
          null, null, null, null,
          null, 'web', null, null,
          '20150428', null, '00', '28-2月 -15 06.55.38.322000 下午', 
          null
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
END P_his_deal_more_90;
/
