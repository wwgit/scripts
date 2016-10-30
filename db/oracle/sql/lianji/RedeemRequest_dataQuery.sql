select * from AC_DIS_FUND_ACCT_BAL
where dis_fund_tx_acct_no = '3041000000695YYLC0B001'

select * from AC_DIS_FUND_ACCT_BAL_INCOME


select * from Bp_Diy_Tx_Fee_Cfg

select * from Bp_Dis_Loaning_Limit_Cfg

select * from Bp_Dis_Loaning_Limit_Tmp_Cfg

update 


/*query basic customer info for redeeming business*/
select distinct n.cust_name,n.cust_no,n.reg_outlet_code,n.reg_trade_chan,n.dis_fund_tx_acct_no,n.reg_dis_code,m.fund_tx_acct_no,
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
                                                                 -- group by b.cust_name
                                                                 -- where c.cust_bank_id='193'
                        )bc
                         left join ac_dis_cust a 
on bc.cust_no=a.cust_no )n
on m.dis_fund_tx_acct_no = n.dis_fund_tx_acct_no 
where m.cust_bank_id = n.cust_bank_id
and n.reg_trade_chan = '2'
--and n.updated_stimestamp like '31-8ÔÂ -15%'
--and s.share_stat = '0' and s.rec_stat = '0' and s.check_flag = '1'
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
)


select fund_type from BP_FUND_BASIC_INFO
where fund_code in ( '481001','481006','162214' );



select count(*) from ac_dis_fund_tx_acct s where s.fund_tx_acct_stat = '0'



select * from BP_FUND_SHARE_CLASS s
where s.share_stat = '0' and s.rec_stat = '0' and s.check_flag = '1'

select * from AC_DIS_FUND_ACCT_BAL where cust_bank_id = '220'and fund_code = '202301'

/*update fund limit*/
update AC_DIS_FUND_ACCT_BAL 
set BALANCE_VOL=99999999, AVAIL_VOL=99999999

update AS_DIS_FUND_BAL_FRZ
set today_frzn_vol = 1

select * from BP_FUND_LIMIT t where t.fund_code = '470006' and t.share_class = 'A' and t.invst_type = '1' and t.busi_code = '024';

select t.avail_vol from ac_dis_fund_acct_bal t;
select t.today_frzn_vol from AS_DIS_FUND_BAL_FRZ t
update AS_DIS_FUND_BAL_FRZ
set today_frzn_vol = 1

select * from ac_cust where cust_no = '1000000168'


select count(*) from  TP_DEAL_OPERATE_REC_bak;

truncate table TP_DEAL_OPERATE_REC;

update  TP_DEAL_OPERATE_REC
set contract_no = '123123'
where cust_no in (
   select distinct n.cust_no from AC_DIS_FUND_ACCT_BAL m
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
on m.dis_fund_tx_acct_no = n.dis_fund_tx_acct_no
)
where m.cust_bank_id = n.cust_bank_id
and n.reg_trade_chan = '2'
and n.updated_stimestamp like '31-8ÔÂ -15%'


 select distinct n.cust_no from AC_DIS_FUND_ACCT_BAL m
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
on m.dis_fund_tx_acct_no = n.dis_fund_tx_acct_no
where m.cust_bank_id = n.cust_bank_id
and n.reg_trade_chan = '2'
and n.updated_stimestamp like '31-8ÔÂ -15%'



insert into tp_deal_operate_rec ( select * from tp_deal_operate_rec_bak ); 



select * from AC_DIS_FUND_ACCT_BAL


begin
  
   P_cursor_usage_Proc;

end;


