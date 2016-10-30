CREATE OR REPLACE PROCEDURE P_AC_CROP_TRADE_REC(Count in number) IS
 
  --V_DIS_APP_SERIAL_NO                      VARCHAR2(24);
  V_SID                                    NUMBER(19);
  V_CONTRACT_NO                            VARCHAR2(24);
  V_CROP_TX_SID_TAIL                       VARCHAR2(12);
  V_CROP_TX_SID_HEAD                       VARCHAR2(8);
  V_CROP_TX_SID                            VARCHAR2(40);
  v_count                                  number;
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.AC_CROP_TRADE_REC; 
    dbms_output.put_line(v_count);
   select max(sid) into V_SID from lct_xm128_trade.AC_CROP_TRADE_REC order by sid desc;
    dbms_output.put_line(V_SID);
    V_SID :=V_SID+1;
   
   for i in 1 .. v_count loop
     
        select substr(SYS_GUID(),5,24) into V_CONTRACT_NO from DUAL;
        --select substr(SYS_GUID(),5,19) into V_SID from DUAL;
        
        select substr(SYS_GUID(),5,12) into V_CROP_TX_SID_TAIL from DUAL;
        select substr(SYS_GUID(),5,8) into V_CROP_TX_SID_HEAD from DUAL;
        
        V_CROP_TX_SID := V_CROP_TX_SID_HEAD||'-01EF-69F4-4F72-'||V_CROP_TX_SID_TAIL;
        --dbms_output.put_line('guid: '|| V_M_UUID );
                
        insert into AC_CROP_TRADE_REC (
        SID, CROP_TX_SID, CROP_OLD_TX_SID, CROP_USERID,
         CROP_TX_TYPE, TX_CODE, CONTRACT_NO, DIS_CODE,
         STIMESTAMP, UPDATED_STIMESTAMP, MEMO, REC_STAT
         )
        values (
        V_SID, V_CROP_TX_SID, null, null,
         null, '202010', V_CONTRACT_NO, 'BD000E001',
         '26-9月 -15 08.58.17.701000 上午', '26-9月 -15 08.58.17.701000 上午', null, '0'
         );

        V_SID :=V_SID+1;
        
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
END P_AC_CROP_TRADE_REC;
/
