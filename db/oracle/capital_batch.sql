select cust_no from tp_dis_trade_app_rec rec where rec.ta_trade_dt='20150827' and cust_no = '1008752104'


select * from io_trade_ack_import where trade_dt = '20150827' and app_dt = '20150828'
select * from cp_pay_order c where c.settle_dt='20150828';
select count(1) from tp_dis_trade_app_rec s where s.ta_trade_dt='20150827' and s.busi_code='089' and s.tx_app_flag='0';
select * from st_trade_ack_settle a where a.ack_dt='20150828' and a.ret_code='0000' and a.from_busi_code='189';
select count(*) from io_trade_ack_import io where io.ack_dt='20150828' and io.busi_code='124';
select * from io_trade_ack_import io where io.ack_dt='20150827';
select h.busi_code,h.fund_code,h.* from his_trade_ack h where h.ack_dt='20150827' and h.busi_code='124';
select * from st_trade_ack_settle a where a.ack_dt='20150827'


select * from io_trade_ack_import

select * from cp_pay_order_suite;
select distinct fund_code from st_trade_ack_settle;
select count(1) from cp_pay_order c where c.settle_dt='20150828' and c.pay;
select * from cp_pay_order_suite s where s.settle_dt='20150828';
select * from cp_pay_order_suite;--生成指令总指令表   settle_dt表示清算日期
select * from cp_pay_order;--生成指令明细表   settle_dt表示清算日期
select * from cp_pay_order c where c.pay_order_no='20150828000810798';
select * from st_trade_ack_settle where ack_dt='20150828'and from_busi_code='189'and ret_code='0000';
select  count(*) from cp_cust2_control s where s.settle_status='3';
create table cp_pay_order_bak001 as select * from cp_pay_order;
create table cp_pay_order_suite_bak001 as select * from cp_pay_order_suite;

 delete from cp_pay_order;
delete from cp_pay_order_suite;
--3清算中4清算成功5清算失败
select count(*) from cp_pay_order;
select * from cp_pay_order_suite;
select count(*) from cp_cust2_control where ack_dt='20150828' and settle_status='3';
update cp_cust2_control set settle_status='1' where settle_status='3' and ack_dt='20150828';
select count(*) from cp_cust2_control where ack_dt='20150828' and settle_status='1';
select * from io_trade_ack_import io where io.ack_dt='20150828';



--check dui zhang
select * from lpt6_xm128_pay.ps_task_param
where param_des = '民生'

