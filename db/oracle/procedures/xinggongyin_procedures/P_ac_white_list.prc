CREATE OR REPLACE PROCEDURE P_ac_white_list(Count in number) IS
 
 V_SNO                              VARCHAR(32);
 v_count                            number;
 
BEGIN
  
   select Count - count(*) into v_count from LPT2_XM128_DEAL.ac_white_list; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop

        select substr(SYS_GUID(),5,32) into V_SNO from DUAL;
         --dbms_output.put_line('guid: '|| V_M_UUID );
        
        insert into ac_white_list (
          SNO, CUST_NAME, CUST_NO, ID_NO,
          ID_TYPE, AVL_STAT, MEMO, REC_STAT,
          CREATOR, MODIFIER, CHECKER, CRE_DT,
          MOD_DT, CHECK_FLAG, STIMESTAMP, UPDATED_STIMESTAMP
          )
        values (
          V_SNO, '杨大大', '123456', '12312312',
          null, '01', null, '01',
          null, null, null, '164805',
          '164805', '04', '28-4月 -15 04.48.05.715000 下午', '28-4月 -15 04.48.05.715000 下午'
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
END P_ac_white_list;
/
