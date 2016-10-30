--QueryTxRecordRequest
select distinct b.cust_no,b.dis_fund_tx_acct_no,b.dis_code from  AC_ICBC_DEAL_ACCT a
left join tp_deal b
on a.cust_no = b.cust_no
where b.dis_fund_tx_acct_no is not null

select distinct b.cust_bank_id, a.cust_no,a.fund_tx_acct_no,b.dis_code
from AC_ICBC_DEAL_ACCT a
left join AC_PIGGY_FRZ b
on a.fund_tx_acct_no = b.fund_tx_acct_no
where b.cust_bank_id is not null
and  a.cust_no in (
     '1008749964',
     '1008749975',
     '1008749986',
     '1008749997',
     '1008750001'
               
     )
     
     

update AC_PIGGY_FRZ 
set deposit_unack_amt=999,
    fast_frzn_amt=1000,
    piggy_pay_amt=100000,
    fast_rede_count=0
where cust_bank_id is not null
