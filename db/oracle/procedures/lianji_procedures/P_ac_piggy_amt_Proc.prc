create or replace procedure P_ac_piggy_amt_Proc(Count in number) is

V_DIS_FUND_TX_ACCT_NO               VARCHAR2(32);
V_CUST_BANK_ID                      VARCHAR2(32);
V_COUNT                             NUMBER;

begin
  
  SELECT COUNT - COUNT(*) INTO V_COUNT FROM lpt5_xm128_trade.ac_piggy_amt;
  select max(cust_bank_id) into V_CUST_BANK_ID from ac_piggy_amt;
  
  if(V_CUST_BANK_ID='') then
     V_CUST_BANK_ID := '00000'; 
  end if;
  
  
  FOR i IN 1..V_COUNT LOOP
    
    select substr(SYS_GUID(),0,32) into V_DIS_FUND_TX_ACCT_NO from DUAL;
    
    insert into lpt5_xm128_trade.ac_piggy_amt (DIS_FUND_TX_ACCT_NO,CUST_BANK_ID, DIS_CODE, BALANCE_AMT,
     REDE_UNACK_AMT, FAST_FRZN_AMT, 
     DEPOSIT_UNACK_AMT, STIMESTAMP)
    values (V_DIS_FUND_TX_ACCT_NO, V_CUST_BANK_ID, 'HB000A001', 0.00000,
     0.00000, 0.00000, 
     0.00000, '29-5月 -14 06.17.41.000000 下午');
     
     V_CUST_BANK_ID := V_CUST_BANK_ID+i;
    
    IF(MOD(i,2000)=0) THEN
      --dbms_output.put_line('已经执行了'||i||'个客户');
      COMMIT;
    END IF;
   END LOOP;
   COMMIT; 
end P_ac_piggy_amt_Proc;
/
