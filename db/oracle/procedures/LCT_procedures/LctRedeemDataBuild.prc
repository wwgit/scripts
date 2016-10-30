create or replace procedure LctRedeemDataBuild Authid Current_User is

V_CntFundAcct       number(19);
V_CntFundBal        number(19);
v_incr              number(19);    
v_num               number(19);
v_incr_tmp          number(19);
v_tmp_table         varchar2(32);

-- getting all records of customer info who has bought related LCT funds
cursor cr is select ab.cust_no,ab.protocal_no,ab.fund_tx_acct_no,
                       ab.cust_bank_id,ab.dis_fund_tx_acct_no,
                       c.id_type,c.id_no,ab.bank_acct
              from (  
                      select b.cust_no,b.dis_fund_tx_acct_no,
                             b.protocal_no,b.fund_tx_acct_no,a.bank_acct,
                             a.cust_bank_id                 
                      from CP_CUST_BANK_ACCT_INFO a 
                      left join AC_DIS_ACCT_TRADE_PLAN b
                      on a.cust_no = b.cust_no
                      where a.bank_acct like 'xianlai003%'and
                            b.dis_fund_tx_acct_no like '%LCT%'                 
              )ab left join ac_cust c
              on ab.cust_no = c.cust_no
              where c.cust_name like 'xianlai03%'
              --and ab.cust_no <= '1008809859'
              and rowNum <= 5000
              order by ab.cust_no;

-- cursor variable definition
cur_record cr%rowtype;

begin
  
  v_incr:=0;
  V_CntFundAcct:=0;
  V_CntFundBal:=0;
  v_num:=0;
  v_incr_tmp:=0;
  v_tmp_table:='DATA_BUILD_REDEEM_TMP';
  
  --create a tmp table to save data that are handled
  select count(1) into v_num from all_tables 
  where TABLE_NAME = v_tmp_table and OWNER='LCT_XM128_TRADE'; 
  
  -- if exist, drop table first
  if(v_num = 1) then
        execute immediate 'drop table '||v_tmp_table;
  end if;
  
  -- create an empty table having 7 columns: cust_no,protocal_no,fund_tx_acct_no,cust_bank_id,
                        --: dis_fund_tx_acct_no,id_type,id_no
  execute immediate '  create table '||v_tmp_table||' (
             corp_acct_no        varchar2(100),
             cust_no             varchar2(10),
             protocal_no         varchar2(12),
             fund_tx_acct_no     varchar2(17),
             cust_bank_id        varchar2(32),
             dis_fund_tx_acct_no varchar2(32),
             id_type             varchar2(1),
             id_no               varchar2(32)                            
      )';
  
  for cur_record in cr loop
    
    -- save data first
   execute immediate 'insert into '||v_tmp_table||' values
   (:1,:2,:3,:4,:5,:6,:7,:8)'
   using cur_record.bank_acct,
         cur_record.cust_no,
         cur_record.protocal_no,
         cur_record.fund_tx_acct_no,
         cur_record.cust_bank_id,
         cur_record.dis_fund_tx_acct_no,
         cur_record.id_type,
         cur_record.id_no;
    v_incr_tmp:=v_incr_tmp+1;
    
    
    -- handle AC_FUND_ACCT begin: 
              --if not exist, insert related record for one cust no;
              --if exist, will not do the inserting
              -- ta codes are 26, 37, 47, 63
    --query for one cust_no ta code is 26 AC_FUND_ACCT
    select count(*) into V_CntFundAcct
           from AC_FUND_ACCT
           where ta_code = '26' and
           fund_tx_acct_no = cur_record.fund_tx_acct_no;
    
    if(V_CntFundAcct = 0) then
          -- AC_FUND_ACCT insert for ta_code = 26
          insert into AC_FUND_ACCT (
           FUND_ACCT_NO, FUND_TX_ACCT_NO, TA_CODE, FUND_ACCT_STAT,
           REG_DT, UD_DT, CAN_DT, STIMESTAMP, UPDATED_STIMESTAMP
           )
          values (
          '26'||cur_record.cust_no, cur_record.fund_tx_acct_no, '26', '0',
           '20151201', '20151201', null, '01-12月-15 05.49.42.000000 下午',
           '02-12月-15 11.28.09.000000 下午'
           );
           v_incr:=v_incr+1;
           --dbms_output.put_line('inserted one for AC_FUND_ACCT :ta code 26');      
    end if;
    V_CntFundAcct:=0;
    
    --query for one cust_no ta code is 37 AC_FUND_ACCT
   select count(*) into V_CntFundAcct
           from AC_FUND_ACCT
           where ta_code = '37' and
           fund_tx_acct_no = cur_record.fund_tx_acct_no;
    
    if(V_CntFundAcct = 0) then
           -- AC_FUND_ACCT insert for ta_code = 37
            insert into AC_FUND_ACCT (
             FUND_ACCT_NO, FUND_TX_ACCT_NO, TA_CODE, FUND_ACCT_STAT,
             REG_DT, UD_DT, CAN_DT, STIMESTAMP, UPDATED_STIMESTAMP
             )
            values (
             '37'||cur_record.cust_no, cur_record.fund_tx_acct_no, '37', '0',
             '20151201', '20151201', null, '01-12月-15 05.49.42.000000 下午',
             '02-12月-15 11.28.09.000000 下午'
             );
             v_incr:=v_incr+1;
             --dbms_output.put_line('inserted one for AC_FUND_ACCT :ta code 37'); 
    end if;
    V_CntFundAcct:=0;
    
    --query for one cust_no ta code is 47 AC_FUND_ACCT
   select count(*) into V_CntFundAcct
           from AC_FUND_ACCT
           where ta_code = '47' and
           fund_tx_acct_no = cur_record.fund_tx_acct_no;
    
    if(V_CntFundAcct = 0) then
              -- AC_FUND_ACCT insert for ta_code = 47
              insert into AC_FUND_ACCT (
               FUND_ACCT_NO, FUND_TX_ACCT_NO, TA_CODE, FUND_ACCT_STAT,
               REG_DT, UD_DT, CAN_DT, STIMESTAMP, UPDATED_STIMESTAMP
               )
              values (
               '47'||cur_record.cust_no, cur_record.fund_tx_acct_no, '47', '0',
               '20151201', '20151201', null, '01-12月-15 05.49.42.000000 下午',
               '02-12月-15 11.28.09.000000 下午'
               ); 
               v_incr:=v_incr+1;
               --dbms_output.put_line('inserted one for AC_FUND_ACCT :ta code 47');
    end if;
    V_CntFundAcct:=0; 
    
    --query for one cust_no ta code is 63 AC_FUND_ACCT
    select count(*) into V_CntFundAcct
           from AC_FUND_ACCT
           where ta_code = '63' and
           fund_tx_acct_no = cur_record.fund_tx_acct_no;
    
    if(V_CntFundAcct = 0) then
              -- AC_FUND_ACCT insert for ta_code = 63
            insert into AC_FUND_ACCT (
             FUND_ACCT_NO, FUND_TX_ACCT_NO, TA_CODE, FUND_ACCT_STAT,
             REG_DT, UD_DT, CAN_DT, STIMESTAMP, UPDATED_STIMESTAMP
             )
            values (
             '63'||cur_record.cust_no, cur_record.fund_tx_acct_no, '63', '0',
             '20151201', '20151201', null, '01-12月-15 05.49.42.000000 下午',
             '02-12月-15 11.28.09.000000 下午'
             );
             v_incr:=v_incr+1;
             --dbms_output.put_line('inserted one for AC_FUND_ACCT :ta code 63');         
    end if;
    V_CntFundAcct:=0;-- reset to zero for next loop
   -- handle AC_FUND_ACCT end
   
   
   -- handle AC_DIS_FUND_ACCT_BAL begin:
              --if not exist, insert related record for one cust no;
              --if exist, will not do the inserting
              -- ta codes are 26, 37, 47, 63
   --query for one cust_no ta code is 37 AC_DIS_FUND_ACCT_BAL
   select count(*) into V_CntFundBal
       from AC_DIS_FUND_ACCT_BAL A
       where A.ta_code = '37' and
       A.dis_fund_tx_acct_no = cur_record.dis_fund_tx_acct_no and
       A.cust_bank_id = cur_record.cust_bank_id;
   
   if(V_CntFundBal = 0) then
           --AC_DIS_FUND_ACCT_BAL insert for ta_code = 37
           insert into AC_DIS_FUND_ACCT_BAL (
           DIS_FUND_TX_ACCT_NO, DIS_CODE, PROTOCAL_NO, FUND_TX_ACCT_NO,
           FUND_CODE, FUND_ACCT_NO, BALANCE_VOL, SHARE_CLASS,
           AVAIL_VOL, FRZN_VOL, JUST_FRZN_VOL, TA_CODE,
           REG_DT, UD_DT, LAST_SUBS_DT, CRE_DT,
           MOD_DT, STIMESTAMP, CUST_BANK_ID
           )
          values (
           cur_record.dis_fund_tx_acct_no, 'LCT00K001', 
           cur_record.protocal_no, cur_record.fund_tx_acct_no,
           '000328', '37'||cur_record.cust_no, 99999999.00000, 'A',
           99999999.00000, 0.00000, 0.00000, '37',
           '20151201', '20151201', null, null,
           null, '02-12月-15 11.28.09.000000 下午',
           cur_record.cust_bank_id
           );
           v_incr:=v_incr+1;
           --dbms_output.put_line('inserted one for AC_DIS_FUND_ACCT_BAL :ta code 37');
   end if;
   V_CntFundBal:=0;
   
   --query for one cust_no ta code is 63 AC_DIS_FUND_ACCT_BAL
   select count(*) into V_CntFundBal
       from AC_DIS_FUND_ACCT_BAL A
       where A.ta_code = '63' and
       A.dis_fund_tx_acct_no = cur_record.dis_fund_tx_acct_no and
       A.cust_bank_id = cur_record.cust_bank_id;
   
   if(V_CntFundBal = 0) then
            --AC_DIS_FUND_ACCT_BAL insert for ta_code = 63
            insert into AC_DIS_FUND_ACCT_BAL (
             DIS_FUND_TX_ACCT_NO, DIS_CODE, PROTOCAL_NO, FUND_TX_ACCT_NO,
             FUND_CODE, FUND_ACCT_NO, BALANCE_VOL, SHARE_CLASS,
             AVAIL_VOL, FRZN_VOL, JUST_FRZN_VOL, TA_CODE,
             REG_DT, UD_DT, LAST_SUBS_DT, CRE_DT,
             MOD_DT, STIMESTAMP, CUST_BANK_ID
             )
            values (
             cur_record.dis_fund_tx_acct_no, 'LCT00K001',
             cur_record.protocal_no, cur_record.fund_tx_acct_no,
             '000609', '63'||cur_record.cust_no, 99999999.00000, 'A',
             99999999.00000, 0.00000, 0.00000, '63',
             '20151201', '20151201', null, null,
             null, '02-12月-15 11.28.09.000000 下午',
             cur_record.cust_bank_id
             );
             v_incr:=v_incr+1;
             --dbms_output.put_line('inserted one for AC_DIS_FUND_ACCT_BAL :ta code 63');
   end if;
   V_CntFundBal:=0;
   
   --query for one cust_no ta code is 47 AC_DIS_FUND_ACCT_BAL
   select count(*) into V_CntFundBal
       from AC_DIS_FUND_ACCT_BAL A
       where A.ta_code = '47' and
       A.dis_fund_tx_acct_no = cur_record.dis_fund_tx_acct_no and
       A.cust_bank_id = cur_record.cust_bank_id;  
         
   if(V_CntFundBal = 0) then
              --AC_DIS_FUND_ACCT_BAL insert for ta_code = 47
              insert into AC_DIS_FUND_ACCT_BAL (
               DIS_FUND_TX_ACCT_NO, DIS_CODE, PROTOCAL_NO, FUND_TX_ACCT_NO,
               FUND_CODE, FUND_ACCT_NO, BALANCE_VOL, SHARE_CLASS,
               AVAIL_VOL, FRZN_VOL, JUST_FRZN_VOL, TA_CODE,
               REG_DT, UD_DT, LAST_SUBS_DT, CRE_DT,
               MOD_DT, STIMESTAMP, CUST_BANK_ID
               )
              values (
              cur_record.dis_fund_tx_acct_no, 'LCT00K001',
               cur_record.protocal_no, cur_record.fund_tx_acct_no,
               '000697', '47'||cur_record.cust_no, 99999999.00000, 'A',
               99999999.00000, 0.00000, 0.00000, '47',
               '20151028', '20151028', null, null,
               null, '02-12月-15 11.28.09.000000 下午',
               cur_record.cust_bank_id
               );
               v_incr:=v_incr+1;
               --dbms_output.put_line('inserted one for AC_DIS_FUND_ACCT_BAL :ta code 47');
   end if;
   V_CntFundBal:=0;
   
   --query for one cust_no ta code is 26 AC_DIS_FUND_ACCT_BAL
   select count(*) into V_CntFundBal
       from AC_DIS_FUND_ACCT_BAL A
       where A.ta_code = '26' and
       A.dis_fund_tx_acct_no = cur_record.dis_fund_tx_acct_no and
       A.cust_bank_id = cur_record.cust_bank_id; 
         
    if(V_CntFundBal = 0) then
             --AC_DIS_FUND_ACCT_BAL insert for ta_code = 26
             insert into AC_DIS_FUND_ACCT_BAL (
             DIS_FUND_TX_ACCT_NO, DIS_CODE, PROTOCAL_NO, FUND_TX_ACCT_NO,
             FUND_CODE, FUND_ACCT_NO, BALANCE_VOL, SHARE_CLASS,
             AVAIL_VOL, FRZN_VOL, JUST_FRZN_VOL, TA_CODE,
             REG_DT, UD_DT, LAST_SUBS_DT, CRE_DT,
             MOD_DT, STIMESTAMP, CUST_BANK_ID
             )
            values (
            cur_record.dis_fund_tx_acct_no, 'LCT00K001', 
            cur_record.protocal_no, cur_record.fund_tx_acct_no,
             '260112', '26'||cur_record.cust_no, 99999999.00000, 'A',
             99999999.00000, 0.00000, 0.00000, '26',
             '20151028', '20151028', null, null,
             null, '02-12月-15 11.28.09.000000 下午', 
             cur_record.cust_bank_id
             );
             v_incr:=v_incr+1;
             --dbms_output.put_line('inserted one for AC_DIS_FUND_ACCT_BAL :ta code 26');     
    end if;     
    V_CntFundBal:=0; -- reset to zero for next loop
    -- handle AC_DIS_FUND_ACCT_BAL end
    
    -- batch commit for ac_fund_acct and AC_DIS_FUND_ACCT_BAL;
    if(mod(v_incr,800)=0 and v_incr<>0) then
       dbms_output.put_line('do commit for '||v_incr||' records !');
       commit;     
    end if;
    
    -- batch commit for DATA_BUILD_REDEEM_TMP;
    if(mod(v_incr_tmp,800)=0 and v_incr_tmp<>0) then
       commit;
    end if;
  end loop;
  dbms_output.put_line('do commit for '||v_incr||' records !');
  commit;
  
exception
    when others then
      dbms_output.put_line('exception------');
      DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode);
      DBMS_OUTPUT.put_line('sqlerrm : ' ||sqlerrm);
      rollback;
  
end LctRedeemDataBuild;
/
