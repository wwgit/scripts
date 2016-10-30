CREATE OR REPLACE PROCEDURE P_cursor_usage_Proc IS

v_sid  number(19);

--declare
 -- type definition
 --  cursor cc is select outlet_code from tp_deal_operate_rec where rownum<50;
 cursor cn is select distinct n.cust_name,n.cust_no,n.reg_outlet_code,n.reg_trade_chan,n.dis_fund_tx_acct_no,n.reg_dis_code,m.fund_tx_acct_no,
                      n.cust_bank_id, n.id_no,n.cust_tx_passwd, m.fund_code, m.protocal_no, m.share_class
                       from AC_DIS_FUND_ACCT_BAL m                     
           left join (
                      select bc.cust_name,bc.cust_no,bc.reg_outlet_code,reg_trade_chan,bc.dis_fund_tx_acct_no,bc.reg_dis_code,
                      bc.cust_bank_id, bc.id_no,a.cust_tx_passwd,a.updated_stimestamp from (
                                                                select b.cust_name,b.cust_no,b.reg_outlet_code,reg_trade_chan,b.reg_dis_code,
                                                                b.id_no,c.dis_fund_tx_acct_no,c.cust_bank_id
                                                                from ac_cust b 
                                                                left join AC_DIS_BANK_CARD c
                                                                --left join 
                                                                on b.cust_no=c.cust_no
                        )bc
                         left join ac_dis_cust a 
on bc.cust_no=a.cust_no )n
on m.dis_fund_tx_acct_no = n.dis_fund_tx_acct_no 
where m.cust_bank_id = n.cust_bank_id
and n.reg_trade_chan = '2'
and m.fund_code in (select s.fund_code from BP_FUND_SHARE_CLASS s where s.share_stat = '0' and s.rec_stat = '0' and s.check_flag = '1')
and m.protocal_no like '1%'
and m.fund_tx_acct_no in ( select j.fund_tx_acct_no from AC_FUND_ACCT j where j.fund_acct_stat = '0' and m.ta_code = j.ta_code )
and m.fund_code in (
    select aa.fund_code from BP_FUND_BASIC_INFO aa ,bp_fund_share_class dd
    ,BP_FUND_NAV_STATUS bb ,sp_workday cc
    where
    aa.fund_code = dd.fund_code
    and aa.fund_code = bb.fund_code
    and bb.share_class = dd.share_class
    and bb.trade_dt = '20150827'
    and bb.trade_dt = cc.workday
    --and b.share_class = 'A'
    and aa.fund_type = '0'
);

 -- cursor variable definition
  cursor_var cn%rowtype;
  
begin
  
   select max(sid) into v_sid from lpt4_xm128_trade.Bp_Diy_Tx_Fee_Cfg;
  
   for cursor_var in cn loop
     
   v_sid:=v_sid+1;
        
    dbms_output.put_line(cursor_var.fund_code);
    
    insert into Bp_Diy_Tx_Fee_Cfg (
       SID, BUSI_CODE, FUND_CODE, SERVICE_FEE_DISC,
       SERVICE_FEE_RATE, START_DT, START_TM, END_DT,
       END_TM, REC_STAT, CHECK_FLAG, CREATOR,
       MODIFIER, CHECKER, CRE_DT, MOD_DT,
       STIMESTAMP, UPDATED_STIMESTAMP
     )
    values (
      v_sid, '089', cursor_var.fund_code, 1.0000,
      0.0001, '20150801', '000000', '20150928',
      '235959', '0', '1', 'ssq',
      'ssq', 's001', '20150824', '20150824',
      '24-8月 -15 02.45.49.643000 下午', '24-8月 -15 03.59.41.107000 下午'
      );

   
   end loop;

exception
    when others then
      dbms_output.put_line('exception------');
      DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode);
      DBMS_OUTPUT.put_line('sqlerrm : ' ||sqlerrm);
      rollback;
END P_cursor_usage_Proc;
/
