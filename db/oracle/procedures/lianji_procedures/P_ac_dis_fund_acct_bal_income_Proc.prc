CREATE OR REPLACE PROCEDURE P_ac_dis_fund_acct_bal_Proc(Count in number) IS
 

  V_FUND_ACCT_NO VARCHAR2(12);
  V_CUST_BANK_ID VARCHAR2(32);
  V_INIT_CNT VARCHAR(9) := '200000001';
        
  v_count     number;
 
BEGIN
  
   select Count - count(*) into v_count from lpt5_xm128_trade.ac_dis_fund_acct_bal;
      
   for i in 1 .. v_count loop
     
     V_FUND_ACCT_NO := 'FB'||V_INIT_CNT;
     V_CUST_BANK_ID := 'CC'||V_INIT_CNT;
 
      insert into ac_dis_fund_acct_bal (DIS_FUND_TX_ACCT_NO, DIS_CODE, PROTOCAL_NO, FUND_TX_ACCT_NO, 
                                     FUND_CODE, FUND_ACCT_NO, BALANCE_VOL, SHARE_CLASS, AVAIL_VOL, FRZN_VOL, JUST_FRZN_VOL, 
                                     TA_CODE, REG_DT, UD_DT, LAST_SUBS_DT, CRE_DT, MOD_DT, STIMESTAMP, CUST_BANK_ID)
      values ('3041000000235HB000A001', 'HB000A001', '10000007237', '3041000000235', 
      '370010', V_FUND_ACCT_NO, 0.00000, 'A', 0.00000, 0.00000, 0.00000, 
      '37', null, '20120507', '20120504', '20120507', '20120507', '07-5月 -12 12.00.00.000000 上午', V_CUST_BANK_ID);
      V_INIT_CNT := V_INIT_CNT+1;
      if (mod(i, 1000) = 0) then
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
END P_ac_dis_fund_acct_bal_Proc;
/
