CREATE OR REPLACE PROCEDURE P_ac_dis_fund_tx_acct_Proc(Count in number) IS
 
  V_DIS_FUND_TX_ACCT_NO VARCHAR2(32);
  V_FUND_TX_ACCT_NO VARCHAR2(17);
  V_DIS_CODE VARCHAR2(16);
  V_INIT_CNT VARCHAR2(7);   
  V_CUST_NO VARCHAR2(10);
  V_REG_DT VARCHAR2(8) := '20150308';
  v_count     number;
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.ac_dis_fund_tx_acct;
      
   for i in 1 .. v_count loop
     
     select substr(SYS_GUID(),4,6) into V_INIT_CNT from DUAL;
     select substr(SYS_GUID(),5,17) into V_FUND_TX_ACCT_NO from DUAL;
    -- V_FUND_TX_ACCT_NO := '404200'||V_INIT_CNT;
     V_DIS_CODE := 'FAC'||V_INIT_CNT;
     V_DIS_FUND_TX_ACCT_NO := V_FUND_TX_ACCT_NO||V_DIS_CODE;
     V_CUST_NO := 'CD'||V_INIT_CNT;
     
      
      insert into lct_xm128_trade.ac_dis_fund_tx_acct (DIS_FUND_TX_ACCT_NO, DIS_CODE, CUST_NO, FUND_TX_ACCT_NO, 
      FUND_TX_ACCT_STAT, DIS_CUST_ID, REG_DT, UD_DT, CAN_DT, 
      STIMESTAMP, UPDATED_STIMESTAMP)
      values (V_DIS_FUND_TX_ACCT_NO,V_DIS_CODE,V_CUST_NO,V_FUND_TX_ACCT_NO, 
      '0', '1000156238YYLC0B001', V_REG_DT, null, null, 
      '26-11月 -15 12.40.57.760000 下午', '08-3月 -15 06.45.01.000000 下午');

    --  V_INIT_CNT := V_INIT_CNT+1;
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
END P_ac_dis_fund_tx_acct_Proc;
/
