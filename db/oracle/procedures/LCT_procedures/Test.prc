create or replace procedure Test is

v_num               number(19);
v_incr_tmp          number(19);


begin
  
  v_num:=0;
  v_incr_tmp:=0;
   --create a tmp table to save data that are handled
  select count(1) into v_num from all_tables 
  where TABLE_NAME = 'DATA_BUILD_REDEEM_TMP' and OWNER='LCT_XM128_TRADE'; 
  
  -- if exist, drop table first
  if(v_num = 1) then
        execute immediate 'drop table DATA_BUILD_REDEEM_TMP';
  end if;
  
  -- create an empty table having 7 columns: cust_no,protocal_no,fund_tx_acct_no,cust_bank_id,
                        --: dis_fund_tx_acct_no,id_type,id_no
  execute immediate 'create table '||'DATA_BUILD_REDEEM_TMP'||' (
             cust_no             varchar2(10),
             protocal_no         varchar2(12),
             fund_tx_acct_no     varchar2(17),
             cust_bank_id        varchar2(32),
             dis_fund_tx_acct_no varchar2(32),
             id_type             varchar2(1),
             id_no               varchar2(32)                            
      )';
      
      
  execute immediate 'insert into '|| 'DATA_BUILD_REDEEM_TMP '||'values'||'(
       123,
       123,
       123,
       123,
       123,
       0,
       123
    )';
 --  execute immediate 'commit';
 commit;
  
end Test;
/
