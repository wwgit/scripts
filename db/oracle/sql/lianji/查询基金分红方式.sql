select t.*,basc.*,dm.*,p.*
from (
select * from ac_dis_fund_acct_bal where fund_tx_acct_no = ? and dis_code = ? and avail_vol > 0
) t
left join ac_acct_div_mode dm
on t.fund_tx_acct_no = dm.fund_tx_acct_no
      and t.fund_code = dm.fund_code
      and t.fund_acct_no = dm.fund_acct_no
      and t.share_class = dm.share_class
left join bp_fund_basic_info basc on t.fund_code = basc.fund_code
left join(
           select * from ac_dis_acct_trade_plan where cust_no = ?
      ) p on t.protocal_no=p.protocal_no and t.dis_fund_tx_acct_no=p.dis_fund_tx_acct_no 
where p.protocal_type<>'3'