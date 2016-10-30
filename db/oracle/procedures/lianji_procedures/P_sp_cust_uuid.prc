CREATE OR REPLACE PROCEDURE P_sp_cust_uuid(Count in number) IS
 
  V_UUID_SERIAL_NO            VARCHAR2(24);
  V_M_UUID                    VARCHAR2(32);
  V_CUST_NO                   VARCHAR2(10);
  V_INIT_CNT                  VARCHAR2(8) := '10000000';
  v_count                     number;
 
BEGIN
  
   select Count - count(*) into v_count from lpt5_xm128_trade.sp_cust_uuid; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop
     
      select substr(SYS_GUID(),0,32) into V_M_UUID from DUAL;
      --dbms_output.put_line('guid: '|| V_M_UUID );
       
       V_CUST_NO :='CN'||V_INIT_CNT;
       V_UUID_SERIAL_NO := 'UU'||V_INIT_CNT;
        
      insert into  lpt5_xm128_trade.sp_cust_uuid (
       UUID_SERIAL_NO, CUST_NO, M_UUID, DIS_CODE,
       OUTLET_CODE, REC_STAT, CRE_DT, STIMESTAMP
       )
      values (
       '813', '1003562984', 'd0592ad69f0acb2597b43165ccfca841', 'HB000A001',
       'A20140301', '0', null, '27-8月 -14 06.22.50.309000 下午'
       );

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
END P_sp_cust_uuid;
/
