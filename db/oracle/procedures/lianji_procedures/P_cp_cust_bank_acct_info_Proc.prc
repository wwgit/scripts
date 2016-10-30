CREATE OR REPLACE PROCEDURE P_cp_cust_bank_acct_info_Proc(Count in number) IS

 V_CUST_BANK_ID         VARCHAR2(32);
 V_CUST_NO       VARCHAR2(10) := '12000000';
 V_BANK_ACCT_NAME    VARCHAR2(180)  := 'leon ';
 V_REC_STAT VARCHAR2(1) := '0';
 V_CREATOR VARCHAR2(100) := 'by procedure';
 V_CHECK_FLAG VARCHAR(2) := '1';
 V_CRE_DT VARCHAR2(8) := '20150310';
 V_BANK_ACCT VARCHAR2(100):= '6225881210000000';
  
 V_BANK_CODE VARCHAR2(3) := '308';
 V_BANK_REGION_CODE VARCHAR2(12) := '308290003011';
 V_BANK_REGION_NAME VARCHAR2(90) := '招商银行上海分行';
 V_PROV_CODE VARCHAR2(2) := '20';
 V_CITY_CODE VARCHAR2(6) := '200000';
 V_INIT_CNT VARCHAR(7) := '120001';
 v_count     number;
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.cp_cust_bank_acct_info;
   
 /*  select bank_code,bank_region_code,bank_region_name,prov_code,city_code
   into V_BANK_CODE,V_BANK_REGION_CODE,V_BANK_REGION_NAME,V_PROV_CODE,V_CITY_CODE
   from lpt4_trade.cp_cust_bank_acct_info
   where bank_region_name='招商银行上海分行'and bank_acct_name='何亚玲';*/
   
   
   for i in 1 .. v_count loop
 
     V_CUST_NO := V_CUST_NO+1;   
     V_INIT_CNT := V_INIT_CNT+1;
     --V_BANK_ACCT_NAME := V_BANK_ACCT_NAME|| V_CUST_NO;
    
     V_CUST_BANK_ID :='u'||V_INIT_CNT;
     
    -- dbms_output.put_line(V_CUST_NO);
    -- dbms_output.put_line(V_INIT_CNT);
   --  dbms_output.put_line(V_BANK_ACCT_NAME);
     
     insert INTO lct_xm128_trade.cp_cust_bank_acct_info(
             cust_bank_id,cust_no,bank_acct_name,bank_acct,
             rec_stat,creator,check_flag,cre_dt,
             bank_code,bank_region_code,bank_region_name,prov_code,city_code
              )
     values(
              substr(SYS_GUID(),1,30),V_CUST_NO,V_BANK_ACCT_NAME,V_BANK_ACCT,
              V_REC_STAT,V_CREATOR,V_CHECK_FLAG,V_CRE_DT,
              V_BANK_CODE,V_BANK_REGION_CODE,V_BANK_REGION_NAME,V_PROV_CODE,V_CITY_CODE
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
END P_cp_cust_bank_acct_info_Proc;
/
