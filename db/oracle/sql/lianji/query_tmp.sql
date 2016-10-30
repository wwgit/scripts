select count(*) from bt_idno_verify_content
select count(*) from bt_idno_verify
select count(*) from bt_idno_verify_content

select * from BP_FUND_BASIC_INFO

select * from QueryHisAcctBalRequest


select * from bt_idno_verify_content
order by sid desc




select max(cust_bank_id) from ac_dis_bank_card

order by cust_no desc


select cust_no,fund_code from TP_DIS_TRADE_APP_REC
-- a.cust_no,b.invst_type,a.fund_code
select distinct(a.cust_no),bc.fund_code,bc.invst_type from (
                select m.fund_code,n.invst_type from BP_FUND_BASIC_INFO m 
                left join BP_FUND_FEE_RATE n
                 on m.fund_code = n.fund_code 
                 where n.invst_type <> ''
               )bc
               right join TP_DIS_TRADE_APP_REC a 
on a.fund_code = bc.fund_code




