select distinct tf.* from ac_dis_fund_tx_acct c left join (
              select distinct ab.cust_no,ab.cust_name,ab.id_no,ab.id_type, 
                     ab.corp_acct_no,ab.corp_inst_code,ab.corp_acct_bind_stat,
                     t.outlet_code,t.dis_code,t.fund_tx_acct_no,t.cust_bank_id,t.pay_sign,t.fund_acct_stat
              from (
                   select a.cust_no,a.cust_name,a.id_no,a.id_type,
                   b.corp_acct_no,b.corp_inst_code,b.corp_acct_bind_stat from ac_cust a right join ac_corp_acct_bind b 
                   on a.cust_no = b.cust_no 
              )ab
              right join 
                ( 
                    select tt.cust_no,tt.fund_tx_acct_no,tt.cust_bank_id,tt.pay_sign,
                    ff.fund_acct_stat,bb.*
                     from AC_DIS_BANK_CARD tt left join ac_fund_acct ff
                       on tt.fund_tx_acct_no = ff.fund_tx_acct_no
                       left join (
                           select u.dis_code,u.outlet_code
                           from BP_OUTLET u left join BP_DIS h
                           on u.dis_code = h.dis_code  
                           where u.outlet_name = '理财通' --理财通用户                     
                       )bb
                       on tt.dis_code = bb.dis_code
                       where tt.is_valid = '1'
                       and ff.fund_acct_stat = '0' --ac_fund_acct 基金账号状态：正常                  
                )t --AC_DIS_BANK_CARD 有效
                on ab.cust_no = t.cust_no
                   -- and t.pay_sign = '2'   --AC_DIS_BANK_CARD  代扣签约状态：已开通
                   --and t.bank_card_cancel_dt is null -- AC_DIS_BANK_CARD 银行卡注销日期为空
              )tf
on tf.cust_no = c.cust_no
where 
--ab.cust_name like 'walterwhite01' and
c.fund_tx_acct_stat = '0' and --开户正常
tf.corp_acct_bind_stat = '2' -- 已绑卡



select * from ac_dis_fund_tx_acct


select * from ac_dis_cust

select * from ac_corp_acct_bind
