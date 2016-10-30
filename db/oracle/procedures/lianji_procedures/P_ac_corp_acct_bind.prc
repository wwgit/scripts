CREATE OR REPLACE PROCEDURE P_ac_corp_acct_bind(Count in number) IS
 
  V_CORP_ACCT_BIND_ID         VARCHAR2(32);
  V_CORP_ACCT_NO              VARCHAR2(32);
  V_CUST_NO                   VARCHAR2(10);
  V_INIT_CNT                  VARCHAR2(8) := '10000000';
  v_count                     number;
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.ac_corp_acct_bind; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop
     
      select substr(SYS_GUID(),0,32) into V_CORP_ACCT_BIND_ID from DUAL;
      --dbms_output.put_line('guid: '|| V_CORP_ACCT_BIND_ID );
     
       V_CUST_NO :='CN'||V_INIT_CNT;
       V_CORP_ACCT_NO := 'CA'||V_INIT_CNT;
        
      insert into lct_xm128_trade.ac_corp_acct_bind (
         CORP_ACCT_BIND_ID, CORP_ACCT_NO, CORP_INST_TYPE, CORP_INST_CODE,
         CUST_NO, ID_TYPE, ID_NO, CORP_ACCT_BIND_STAT, 
         OPERATE_IP, BIND_DT, BIND_TM, IS_VALID, 
         STIMESTAMP
       )
      values (
         V_CORP_ACCT_BIND_ID, V_CORP_ACCT_NO, null, 'W20130702',
         V_CUST_NO, '0', '310115198809186321', '3', 
         null, '20150308', '164141', '0', 
         '8-3月 -15 12.25.03.270000 下午');

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
END P_ac_corp_acct_bind;
/
