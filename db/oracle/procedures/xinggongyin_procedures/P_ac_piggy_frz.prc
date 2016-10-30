CREATE OR REPLACE PROCEDURE P_ac_piggy_frz(Count in number) IS
 
 V_DIS_FUNC_TX_ACCT_NO              VARCHAR(32);
 V_CUST_BANK_ID                     VARCHAR(32);
 V_PD_TRADE_DT                      VARCHAR2(8) := '20150706';
 V_APP_DT                           VARCHAR2(8) := '20150706';
 v_count                            number;
 
BEGIN
  
   select Count - count(*) into v_count from LPT2_XM128_DEAL.ac_piggy_frz; 
   -- dbms_output.put_line('count that need to be done');
    -- dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop

        select substr(SYS_GUID(),5,32) into V_DIS_FUNC_TX_ACCT_NO from DUAL;
        select substr(SYS_GUID(),5,32) into V_CUST_BANK_ID from DUAL;
        
        --dbms_output.put_line('guid: '|| V_M_UUID );
        
    insert into AC_PIGGY_FRZ (
        DIS_FUND_TX_ACCT_NO, CUST_BANK_ID, PD_TRADE_DT, APP_DT,
        FUND_TX_ACCT_NO, DIS_CODE, DEPOSIT_UNACK_AMT, REDE_UNACK_AMT,
        STIMESTAMP, UPDATED_STIMESTAMP
		)
values (
		V_DIS_FUNC_TX_ACCT_NO,V_CUST_BANK_ID, V_PD_TRADE_DT,V_APP_DT,
		'3041008808172', 'HB000A001', null, 0.00000,
		'06-7月 -15 01.25.42.130000 下午', '06-7月 -15 01.25.42.321000 下午');
      
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
END P_ac_piggy_frz;
/
