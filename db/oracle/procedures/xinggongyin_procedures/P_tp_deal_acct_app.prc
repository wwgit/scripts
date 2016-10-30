CREATE OR REPLACE PROCEDURE P_tp_deal_acct_app(Count in number) IS
 
 V_APP_SNO              VARCHAR(32);
 v_count                number;
 
BEGIN
  
   select Count - count(*) into v_count from LPT2_XM128_DEAL.tp_deal_acct_app; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop

        select substr(SYS_GUID(),5,32) into  V_APP_SNO from DUAL;
        --dbms_output.put_line('guid: '|| V_M_UUID );
        
      insert into tp_deal_acct_app (
         APP_SNO, CUST_NO, DIS_FUND_TX_ACCT_NO, FUND_TX_ACCT_NO,
         ICBC_DEAL_ACCT_NO, ACCT_STAT, APP_DT, APP_TM,
         BUSI_CODE, ICBC_ID_TYPE, ID_NO, HOWBUY_COMPANY_NO,
         HOWBUY_CHAN_NO, RET_CODE, RET_MSG, MEMO,
         CREATOR, MODIFIER, CRE_DT, MOD_DT,
         STIMESTAMP, UPDATED_STIMESTAMP
         )
        values (
        V_APP_SNO, '1008749403', '3041008808127HB000A001', '3041008808127',
         '20150428000000010', '01', '20150428', '185537',
         '311', '0', '451301198001010053', '248',
         'HOWBUY', '0000000', '交易成功', null,
         null, null, '20150428', '20150428',
         '28-4月 -15 06.55.37.288000 下午', '28-4月 -15 06.55.37.954000 下午'
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
END P_tp_deal_acct_app;
/
