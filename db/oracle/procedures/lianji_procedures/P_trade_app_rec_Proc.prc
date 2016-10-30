CREATE OR REPLACE PROCEDURE P_cp_cust_bank_acct_info_Proc(Count in number) IS

 V_ID_NO         VARCHAR2(32) := '310104198407223617';
 V_CUST_NO       VARCHAR2(10) := '1114060000';
 V_ID_TYPE       VARCHAR2(1)  := '1';
 V_INVST_TYPE       VARCHAR2(1)  := '1';
 V_CUST_NAME        VARCHAR2(180) := 'leon';
 V_CUST_STAT      VARCHAR2(1) := '1';
 V_REG_DT         VARCHAR2(8) := '20140702';
 V_STIMESTAMP     TIMESTAMP(6) := '25-7月 -13 09.08.13.863000 上午';
 V_ID_ALWAYS_VALID_FLAG VARCHAR2(1) := '1';
 V_ID_VRFY_STAT         VARCHAR2(1)  := '1';
 V_REG_OUTLET_CODE      VARCHAR2(9) := 'W20130701';
 V_REG_TRADE_CHAN       VARCHAR2(1)  := '4';
 V_REG_DIS_CODE         VARCHAR(16) := 'YYLC0B001';
 V_UPDATED_STIMESTAMP   VARCHAR(128) := '04-9月 -14 06.43.06.000000 下午';
  v_count number;
  v_init_cnt number := 11000000;
 
BEGIN
   select Count - count(*) into v_count from lpt4_trade.cp_cust_bank_acct_info;
   dbms_output.put_line(v_count);
  
   for i in 1 .. v_count loop
    --select trunc(10000000+90000000*dbms_random.value) into V_CUST_NO FROM dual;
   --dbms_output.put_line(v_init_cnt);
    
    V_CUST_NO := to_char(v_init_cnt,'00000000');
    --dbms_output.put_line('cust_no='||V_CUST_NO); 
     V_CUST_NAME := 'leon'||V_CUST_NO;
     insert INTO lpt4_trade.cp_cust_bank_acct_info
     (cust_no,cust_name,id_no,id_type,invst_type,cust_stat,reg_dt,stimestamp,
      id_always_valid_flag,id_vrfy_stat,reg_outlet_code,reg_trade_chan,
      reg_dis_code,updated_stimestamp)
     values
     (V_CUST_NO+1,V_CUST_NAME,V_ID_NO,V_ID_TYPE,V_INVST_TYPE,V_CUST_STAT,V_REG_DT,V_STIMESTAMP,
               V_ID_ALWAYS_VALID_FLAG,V_ID_VRFY_STAT,V_REG_OUTLET_CODE, V_REG_TRADE_CHAN,
               V_REG_DIS_CODE,V_UPDATED_STIMESTAMP);
    if (mod(i, 1000) = 0) then
      --dbms_output.put_line('已经执行了'||i||'个客户');
      commit;
    end if;
    v_init_cnt := v_init_cnt+1;
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
