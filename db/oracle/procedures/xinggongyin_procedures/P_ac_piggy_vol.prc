CREATE OR REPLACE PROCEDURE P_ac_piggy_vol(Count in number) IS
 
 V_DIS_FUNC_TX_ACCT_NO              VARCHAR(32);
 V_CUST_BANK_ID                     VARCHAR(32);
 v_count                            number;
 
BEGIN
  
   select Count - count(*) into v_count from LPT2_XM128_DEAL.ac_piggy_vol; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop

        select substr(SYS_GUID(),5,32) into V_DIS_FUNC_TX_ACCT_NO from DUAL;
        select substr(SYS_GUID(),5,32) into V_CUST_BANK_ID from DUAL;
        
        --dbms_output.put_line('guid: '|| V_M_UUID );
        
        insert into ac_piggy_vol (
          DIS_FUND_TX_ACCT_NO, CUST_BANK_ID, FUND_TX_ACCT_NO, DIS_CODE,
          TOTAL_AMT, LASTDAY_INCOME, TOTAL_INCOME, STIMESTAMP,
          UPDATED_STIMESTAMP
          )
        values (
           V_DIS_FUNC_TX_ACCT_NO, V_CUST_BANK_ID, '3041008807968', 'HB000A001',
           31121.00000, 0.00000, 0.00000, '04-6月 -15 11.58.32.000000 下午',
           '05-5月 -15 11.58.32.000000 下午'
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
END P_ac_piggy_vol;
/
