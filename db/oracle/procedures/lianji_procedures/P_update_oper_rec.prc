CREATE OR REPLACE PROCEDURE P_update_TP_DEAL_OPERATE_REC IS
 
 --V_TRADE_DTL_SNO   VARCHAR(32);
 v_count           number;
 v_cust_no         varchar2(8);
 
-- declare 
 cursor cur_1 
 is 
  select distinct n.cust_no,count(n.cust_no) from AC_DIS_FUND_ACCT_BAL m
                          left join (
                                  select bc.cust_name,bc.cust_no,bc.reg_outlet_code,reg_trade_chan,bc.dis_fund_tx_acct_no,bc.reg_dis_code,
                                  bc.cust_bank_id, bc.id_no,a.cust_tx_passwd from (
                                                   select b.cust_name,b.cust_no,b.reg_outlet_code,reg_trade_chan,b.reg_dis_code,
                                                    b.id_no,c.dis_fund_tx_acct_no,c.cust_bank_id
                                                     from ac_cust b left join AC_DIS_BANK_CARD c
                                    on b.cust_no=c.cust_no
                                   -- group by b.cust_name
                                   --where c.cust_bank_id='193'
                                    )bc
                                     left join ac_dis_cust a
                      on bc.cust_no=a.cust_no )n
                      on m.dis_fund_tx_acct_no = n.dis_fund_tx_acct_no;
--open cur_1;

TYPE redeem_rec is RECORD(
 
 cn   AC_DIS_FUND_ACCT_BAL.cust_no%TYPE;


);
 
BEGIN
  
   --select Count - count(*) into v_count from LPT2_XM128_DEAL.tp_trade_dtl; 
    --dbms_output.put_line(v_count);

        --select substr(SYS_GUID(),5,32) into V_TRADE_DTL_SNO from DUAL;
        --dbms_output.put_line('guid: '|| V_M_UUID );
    v_count := 10000001;
    
    open cur_1;
    
    fetch cur_1 into v_cust_no;

    
    dbms_output.put_line('beginning to go into for loop...');
    while cur_1%FOUND loop
                                    
        update  TP_DEAL_OPERATE_REC
            set contract_no = to_char(v_cust_no)
            where cust_no = cust_arr.cust_no;
            
         v_count := v_count+1;
         fetch cur_1 into v_cust_no;
         dbms_output.put_line(v_count);
         
        
         if (mod(v_count, 2000) = 0) then
            dbms_output.put_line('已经执行了'||v_count||'个客户');
            commit;
         end if;
        
   end loop;    
   dbms_output.put_line('end to go into for loop...');         
   commit;

exception
    when others then
      dbms_output.put_line('exception------');
      DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode);
      DBMS_OUTPUT.put_line('sqlerrm : ' ||sqlerrm);
      rollback;
END P_update_TP_DEAL_OPERATE_REC;
/
