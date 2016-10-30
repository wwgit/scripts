CREATE OR REPLACE PROCEDURE P_st_cust_oper_rec_Proc(Count in number) IS
 
  V_CUST_OPER_SERIAL_NO       VARCHAR2(24);
  V_ID_NO                     VARCHAR(32);
  V_TRADE_DT                  VARCHAR(8) := '20150308';
  V_CUST_NO                   VARCHAR(10);
  V_INIT_CNT                  VARCHAR2(8) := '12000000'; 
 
  v_count      number;
 
BEGIN
  
   select Count - count(*) into v_count from lpt5_xm128_trade.st_cust_oper_rec2; 
   -- dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop
     
      select substr(SYS_GUID(),5,24) into V_CUST_OPER_SERIAL_NO from DUAL;
      --dbms_output.put_line('guid: '|| V_CUST_OPER_SERIAL_NO);
     
      V_ID_NO :='3101041981'||V_INIT_CNT;
      V_CUST_NO :='CC'||V_INIT_CNT;
        
      insert into lpt5_xm128_trade.st_cust_oper_rec2 (
        CUST_OPER_SERIAL_NO, TRADE_DT, TX_CODE, CUST_NO, 
        ID_TYPE, ID_NO, TRADE_TM, RET_CODE, 
        RET_MSG, TX_IP, TX_TEL_NO, STIMESTAMP, 
        SELF_MSG, NEW_SELF_MSG, SMS_REMIND_OPTION, EMAIL_REMIND_OPTION, 
        CIPHER_TEXT, DIS_CODE
      )
      values (
        V_CUST_OPER_SERIAL_NO, V_TRADE_DT, '203010', V_CUST_NO, 
        '0', V_ID_NO, '101350', '0000', 
        '9999', '58.32.209.210', null, '10-3月 -15 10.13.50.407000 上午', 
        null, null, null, null, 
        null, 'HB000A001');

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
END P_st_cust_oper_rec_Proc;
/
