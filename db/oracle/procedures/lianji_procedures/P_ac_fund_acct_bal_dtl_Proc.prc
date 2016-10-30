create or replace procedure P_ac_fund_acct_bal_dtl_Proc(Count in number) is

V_BLOTTER_NO               VARCHAR2(32);
--V_ID_NO                     VARCHAR2(32);
V_COUNT                     NUMBER;

begin
  
  SELECT COUNT - COUNT(*) INTO V_COUNT FROM lct_xm128_trade.ac_fund_acct_bal_dtl;
  
  FOR i IN 1..V_COUNT LOOP
    
    select substr(SYS_GUID(),0,32) into V_BLOTTER_NO from DUAL;
    
    insert into lct_xm128_trade.ac_fund_acct_bal_dtl (BLOTTER_NO, DIS_CODE, DIS_FUND_TX_ACCT_NO, PROTOCAL_NO,
     CUST_BANK_ID, FUND_TX_ACCT_NO, FUND_ACCT_NO, FUND_CODE,
     SHARE_CLASS, SHARE_REG_DT, TA_SERIAL_NO, TA_CODE,
     ALLOW_REDE_DT, INIT_VOL, AVAIL_VOL, BALANCE_VOL,
     FRZN_VOL, JUST_FRZN_VOL, DIS_TRANS_SEQ, DIV_DT,
     REG_DT, CRE_DT, MOD_DT, UD_DT,
     STIMESTAMP, DIV_EVERY_DT)
    values (V_BLOTTER_NO, 'HB000A001', '3041000019998HB000A001', '10000043231',
     '3006', '3041000019998', '99F896064927', '519508',
     'A', ' ', '99121030304000000027', '99',
     null, 5000.00000, 0.00000, 0.00000,
     0.00000, 0.00000, '2012103000068419', null,
     null, '20121030', '20130307', '20130307',
     '10-5月 -14 04.25.59.045000 下午', null);
    
    IF(MOD(i,2000)=0) THEN
      --dbms_output.put_line('已经执行了'||i||'个客户');
      COMMIT;
    END IF;
   END LOOP;
   COMMIT; 
end P_ac_fund_acct_bal_dtl_Proc;
/
