CREATE OR REPLACE PROCEDURE P_ac_piggy_income_Proc(Count in number) IS
 

  V_DIS_FUND_TX_ACCT_NO VARCHAR2(32);
  V_CUST_BANK_ID VARCHAR2(32);
  V_INIT_CNT VARCHAR2(7) := '1000001';   
  V_DIS_CODE VARCHAR2(16);
  v_count     number;
  
  V_DIS_CODE_HEAD VARCHAR(9);
 
BEGIN
  
   select Count - count(*) into v_count from lpt5_xm128_trade.ac_piggy_income;
   
   SELECT substr(SYS_GUID(),4,9) INTO V_DIS_CODE_HEAD FROM DUAL;
      
   for i in 1 .. v_count loop
     
     V_DIS_CODE := V_DIS_CODE_HEAD||V_INIT_CNT;
     V_DIS_FUND_TX_ACCT_NO := '3041000080503'||V_DIS_CODE;
     V_CUST_BANK_ID := '3041000080503'||V_DIS_CODE_HEAD||V_INIT_CNT;
     
  --SELECT substr(SYS_GUID(),5,17) INTO V_FUND_TX_ACCT_NO FROM DUAL;
  --SELECT substr(SYS_GUID(),5,12) INTO V_FUND_ACCT_NO FROM DUAL; 
 
    insert into ac_piggy_income (DIS_FUND_TX_ACCT_NO, CUST_BANK_ID, DIS_CODE, SETTLE_INCOME, 
    UNPAY_INCOME, LASTDAY_INCOME, INCOME_DT, SETTLE_INCOME_BK, 
    UNPAY_INCOME_BK, LASTDAY_INCOME_BAK, CRE_DT, STIMESTAMP)
    values (V_DIS_FUND_TX_ACCT_NO, V_CUST_BANK_ID, V_DIS_CODE, 2.82000, 
    0.00000, 0.03403, '20141231', 1.61000, 
    1.09741, 0.03403, '20140912', '05-1月 -15 03.33.53.413000 下午');

      V_INIT_CNT := V_INIT_CNT+1;
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
END P_ac_piggy_income_Proc;
/
