CREATE OR REPLACE PROCEDURE P_cp_cust_pmt_chnl_open(Count in number) IS
 
  V_CUST_PMT_CHNL_ID          VARCHAR2(32);
  V_CUST_BANK_ID              VARCHAR2(32);
  V_INIT_CNT                  VARCHAR2(8) := '10000000';
 
  v_count      number;
 
BEGIN
  
   select Count - count(*) into v_count from lpt5_xm128_trade.cp_cust_pmt_channel_open_info; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop
     
      select substr(SYS_GUID(),0,32) into V_CUST_PMT_CHNL_ID  from DUAL;
      --dbms_output.put_line('guid: '|| V_CUST_PMT_CHNL_ID );
     
      V_CUST_BANK_ID :='CB'||V_INIT_CNT;
        
      insert into lpt5_xm128_trade.cp_cust_pmt_channel_open_info (
        CUST_PMT_CHNL_OPEN_ID, CUST_BANK_ID, PMT_CHANNEL_OPEN_FLAG, PMT_CUST_NO, 
        MEMO, REC_STAT, CREATOR, MODIFIER, 
        CHECKER, CHECK_FLAG, CRE_DT, MOD_DT, 
        PROTO_OPEN_DT, PROTO_CLOSE_DT, PMT_INST_CODE, PMT_TYPE, 
        VRFY_MODEL)
      values (
         V_CUST_PMT_CHNL_ID, V_CUST_BANK_ID, '1', null,
         null, '0', 'procedure', null, 
         'web', '1', '20150308', null, 
         '20150308', null, '1006', '04', 
       '1');

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
END P_cp_cust_pmt_chnl_open;
/
