CREATE OR REPLACE PROCEDURE P_bt_idno_verify_content(Count in number) IS
 
  V_SID                       NUMBER(19);
  --V_INIT_CNT                  VARCHAR2(8) := '18180010';
  v_count                     number;
 
BEGIN
  
   select Count - count(*) into v_count from lpt5_xm128_trade.bt_idno_verify_content; 
    --dbms_output.put_line(v_count);
    
    select max(sid) into V_SID from lpt5_xm128_trade.bt_idno_verify_content;
    V_SID := V_SID+1;
       
   for i in 1 .. v_count loop
        
        insert into lpt5_xm128_trade.bt_idno_verify_content (SID, ID_CONTENT)
        values (V_SID, '<CLOB>');

         V_SID := V_SID+1;
        
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
END P_bt_idno_verify_content;
/
