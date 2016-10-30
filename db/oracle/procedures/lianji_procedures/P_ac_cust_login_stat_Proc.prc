CREATE OR REPLACE PROCEDURE P_ac_cust_login_stat_Proc(Count in number) IS
 
  V_CUST_NO                   VARCHAR2(10);
  V_INIT_CNT                  VARCHAR2(10); 
  v_count                      number;
 
BEGIN
  
   select Count - count(*) into v_count from lpt5_xm128_trade.ac_cust_login_stat;
   select max(cust_no) into V_INIT_CNT from lpt5_xm128_trade.ac_cust_login_stat;
    
    
    V_INIT_CNT := substr(V_INIT_CNT,3,8)+1;
    --dbms_output.put_line(V_INIT_CNT);
   
   for i in 1 .. v_count loop
     
      V_CUST_NO :='CB'||V_INIT_CNT;
        
      insert into lpt5_xm128_trade.ac_cust_login_stat (CUST_NO, LAST_LOGIN, LAST_IP, LOCK_STAT,
       LOCK_TM, LOCK_IP, LOGIN_FAIL_TIMES, TOTAL_TIMES, 
       DIS_CODE)
      values (V_CUST_NO, '20141230181754', '140.206.255.222', '0',
       null, null, 0, 124, 
       'HB000A001');

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
END P_ac_cust_login_stat_Proc;
/
