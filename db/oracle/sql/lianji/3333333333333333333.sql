select distinct n.cust_name,n.cust_no,n.reg_outlet_code,n.reg_trade_chan,n.dis_fund_tx_acct_no,n.reg_dis_code,
                      n.cust_bank_id, n.id_no,n.cust_tx_passwd, m.fund_code, m.protocal_no, m.share_class
                       from AC_DIS_FUND_ACCT_BAL m
         left join (
                      select bc.cust_name,bc.cust_no,bc.reg_outlet_code,reg_trade_chan,bc.dis_fund_tx_acct_no,bc.reg_dis_code,
                      bc.cust_bank_id, bc.id_no,a.cust_tx_passwd from (
                                       select b.cust_name,b.cust_no,b.reg_outlet_code,reg_trade_chan,b.reg_dis_code,
                                        b.id_no,c.dis_fund_tx_acct_no,c.cust_bank_id
                                         from ac_cust b left join AC_DIS_BANK_CARD c
                        on b.cust_no=c.cust_no
                       -- group by b.cust_name
                       -- where c.cust_bank_id='193'
                        )bc
                         left join ac_dis_cust a
on bc.cust_no=a.cust_no )n
on m.dis_fund_tx_acct_no = n.dis_fund_tx_acct_no 
where m.cust_bank_id = n.cust_bank_id
and n.reg_trade_chan = '2'
