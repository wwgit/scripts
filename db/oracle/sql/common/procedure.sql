CREATE OR REPLACE PROCEDURE P_table_Proc(Count in number) IS

 V_ID_NO         VARCHAR2(32) := '310104198407223617';
 V_CUST_NO       VARCHAR2(10) := '1000135315';
 V_ID_TYPE       VARCHAR2(1)  := '1';
 V_INVST_TYPE       VARCHAR2(1)  := '1';
 V_CUST_NAME        VARCHAR2(180) := 'leon35112';
 V_CUST_STAT      VARCHAR2(1) := '1';
 V_REG_DT         VARCHAR2(8) := '20140702';
 V_STIMESTAMP     TIMESTAMP(6) := '25-7月 -13 09.08.13.863000 上午';
 V_ID_ALWAYS_VALID_FLAG VARCHAR2(1) := '1';
 V_ID_VRFY_STAT         VARCHAR2(1)  := '1';
 V_REG_OUTLET_CODE      VARCHAR2(9) := 'W20130701';
 V_REG_TRADE_CHAN       VARCHAR2(1)  := '4';
 V_REG_DIS_CODE         VARCHAR(16) := 'YYLC0B001';
 V_UPDATED_STIMESTAMP   VARCHAR(6) := '04-9月 -14 06.43.06.000000 下午';
 v_count     number;
 
BEGIN
   select Count - count(cust_no) into v_count from lpt4_trade.pro_test;
   for i in 1 .. v_count loop
     insert INTO lpt4_trade.pro_test
     (cust_no,cust_name,id_no,id_type,invst_type,cust_stat,reg_dt,stimestamp,
      id_always_valid_flag,id_vrfy_stat,reg_outlet_code,reg_trade_chan,
      reg_dis_code,updated_stimestamp)
     values
     (V_CUST_NO,V_CUST_NAME,V_ID_NO,V_ID_TYPE,V_INVST_TYPE,CUST_STAT,V_REG_DT,V_STIMESTAMP,
               V_ID_ALWAYS_VALID_FLAG,V_ID_VRFY_STAT,V_REG_OUTLET_CODE, V_REG_TRADE_CHAN,
               V_REG_DIS_CODE,V_UPDATED_STIMESTAMP);
    if (mod(i, 1) = 0) then
      dbms_output.put_line('已经执行了'||i||'个客户');
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
END P_table_Proc;


declare
  -- Non-scalar parameters require additional processing 
  --discodes myvarry_list;
  --protocaltypes myvarry_list;
begin
  P_table_Proc(1);
end;

