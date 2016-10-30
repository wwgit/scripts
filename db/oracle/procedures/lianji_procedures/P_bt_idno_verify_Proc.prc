CREATE OR REPLACE PROCEDURE P_bt_idno_verify_Proc(Count in number) IS
 
  V_SID                   number(19);
  V_ID_NO                 VARCHAR(32);
  V_SSID                  number(19);
  V_ID_CNT                VARCHAR2(8) := '18659475';
  --V_INIT_SSID_CNT         VARCHAR2(8) := '10000000';  
  v_count                 number;
 
BEGIN
  
   select Count - count(*) into v_count from lpt5_xm128_trade.bt_idno_verify;
   
   select max(sid) into V_SID from lpt5_xm128_trade.bt_idno_verify;
   V_SID :=V_SID+1;
   select max(ssid) into V_SSID from lpt5_xm128_trade.bt_idno_verify;
   V_SSID :=V_SSID+1;
      
   for i in 1 .. v_count loop
     
   select substr(sys_guid(),4,8) into V_ID_CNT from dual;
    
   V_ID_NO :='3101041981'||V_ID_CNT;
      
    insert into lpt5_xm128_trade.bt_idno_verify (SID, ID_TYPE, ID_NO, ID_VRFY_STATUS, 
    CTIMESTAMP, UTIMESTAMP, REC_STAT, SSID, 
    CUST_NAME)
    values (V_SID, '0', V_ID_NO, '1', 
    '12-11月-12 08.15.38.059000 下午', '12-11月-12 08.15.38.059000 下午', '0',  V_SSID,
     null);

     V_SID :=V_SID+1;
     V_SSID :=V_SSID+1;
      
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
END P_bt_idno_verify_Proc;
/
