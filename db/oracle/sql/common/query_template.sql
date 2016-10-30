select * from ac_dis_fund_tx_acct 
where fund_tx_acct_no like '304200%'
order by dis_fund_tx_acct_no desc

select count(*) from ac_dis_fund_tx_acct
where fund_tx_acct_no like '304200%'
order by dis_fund_tx_acct_no desc


delete from bt_idno_verify 
where sid like '12______'

select count(*) from st_cust_oper_rec2

select count(*) from bt_idno_verify 

select * from bt_idno_verify 
where sid like '12______'
order by ssid desc


select count(*) from st_cust_oper_rec2
select * from st_cust_oper_rec2
where cust_no like 'CB%'
order by cust_oper_serial_no desc

select * from ac_cust_login_stat
order by cust_no desc

select count(*) from ac_cust_login_stat

delete from ac_cust_login_stat
where cust_no like 'CB%'

select * from bt_idno_verify_content


select * from cp_cust_pmt_channel_open_info
order by CUST_BANK_ID desc

select count(*) from bt_idno_verify

select FUND_ACCT_NO from tp_dis_tx_contract
order by  FUND_ACCT_NO desc

select count(*) from tp_dis_tx_contract

select count(*) from ac_dis_acct_trade_plan

select count(*) from his_piggy_income

select max(sid) from tp_dis_trade_app_rec

select * from bt_idno_verify
--where sid like '12______'
order by sid desc

tp_dis_trade_app_rec
