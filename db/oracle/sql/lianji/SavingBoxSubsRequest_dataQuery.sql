select * from (select distinct a.cust_no,a.cust_name,b.bank_acct from ac_cust a
left join CP_CUST_BANK_ACCT_INFO b 
on a.cust_no = b.cust_no 
where rownum <=500) ab left join ac_dis_cust c
on ab.cust_no = c.cust_no
order by cust_no


select * from AC_DIS_BANK_CARD t

select t.dis_fund_tx_acct_no,b.cust_no,b.cust_name,b.id_no,c.cust_bank_id,b.reg_dis_code,b.reg_outlet_code,b.reg_trade_chan from 
ac_dis_cust a,ac_cust b,CP_CUST_BANK_ACCT_INFO c,AC_DIS_BANK_CARD t
where a.cust_no=b.cust_no
and b.cust_no=c.cust_no
and rownum <=500
and b.cust_no = '1008749627'

update  ac_dis_cust a
set a.cust_tx_passwd='123123'
where a.cust_no= '1008749627'

select a.cust_tx_passwd from ac_dis_cust a
where a.cust_no =  '0008749682'

321183198707210799
select b.cust_name,b.cust_no,b.id_no,b.id_type,c.cust_bank_id, d.dis_code from 
ac_dis_cust a, ac_cust b,CP_CUST_BANK_ACCT_INFO c,ac_dis_fund_tx_acct d
where a.cust_no=b.cust_no
and b.cust_no=c.cust_no
and c.cust_bank_id='193'


and rownum <=500


-- query bc.cust_no,bc.reg_outlet_code,reg_trade_chan
select bc.cust_name,bc.cust_no,bc.reg_outlet_code,reg_trade_chan,bc.dis_fund_tx_acct_no,bc.reg_dis_code,
                      bc.cust_bank_id, bc.id_no from (
                        select b.cust_name,b.cust_no,b.reg_outlet_code,reg_trade_chan,b.reg_dis_code,
                                        b.id_no,c.dis_fund_tx_acct_no,c.cust_bank_id
                                         from ac_cust b left join AC_DIS_BANK_CARD c
                        on b.cust_no=c.cust_no
                       -- group by b.cust_name
                       -- where c.cust_bank_id='193'
                        )bc
                         left join ac_dis_cust a
on bc.cust_no=a.cust_no
where a.cust_no= '1008749436'

--query cust name, cust no,id no, cust bank id, password
select bc.cust_name,bc.cust_no,bc.cust_bank_id,a.cust_tx_passwd,a.*,
                       bc.id_no from (
                        select b.cust_name,b.cust_no,b.id_type,b.invst_type,
                                        b.id_no,c.cust_bank_id,c.rec_stat
                                         from ac_cust b left join  CP_CUST_BANK_ACCT_INFO c
                        on b.cust_no=c.cust_no
                           where c.rec_stat='0'
                       -- group by b.cust_name
                       -- where c.cust_bank_id='193'
                        )bc
                         left join ac_dis_cust a
on bc.cust_no=a.cust_no
--order by a.updated_stimestamp
where  a.updated_stimestamp like '31-8月 -%'
order by a.updated_stimestamp desc
where a.cust_no= '1000000269'

update ac_dis_cust
set updated_stimestamp='28-8月 -15 03.12.19.600000 下午'
where cust_no= '1000000269'

update ac_dis_cust
set updated_stimestamp=To_Date('310815','dd-mm-yy')
where cust_no= '1000000269'



select count(*) from (
                 select b.cust_name,b.cust_no,b.id_type,b.invst_type,
                                        b.id_no,c.cust_bank_id,c.rec_stat
                                         from ac_cust b left join  CP_CUST_BANK_ACCT_INFO c
                        on b.cust_no=c.cust_no
                           where c.rec_stat='0'
                       -- group by b.cust_name
                       -- where c.cust_bank_id='193'
                        )bc
                         left join ac_dis_cust a
on bc.cust_no=a.cust_no
where  a.updated_stimestamp like '31-8月 -15%'
order by a.updated_stimestamp desc


select * from ac_dis_cust a

--FtxSavingboxSubsRequest
--query bank id, cust no,fund_tx_acct_no, dis_code, outlet_code, bank_acct
select bc.cust_bank_id,bc.cust_no,bc.reg_dis_code,bc.reg_outlet_code,bc.bank_acct,
                       bc.id_no,bc.cust_name,bc.reg_trade_chan from (
                            select b.cust_name,b.cust_no,b.id_type,b.invst_type,
                                            b.id_no,c.cust_bank_id,c.rec_stat,
                                            b.reg_outlet_code,b.reg_dis_code,c.bank_acct,
                                            b.reg_trade_chan                                        
                            from ac_cust b left join  CP_CUST_BANK_ACCT_INFO c
                            on b.cust_no=c.cust_no
                               where c.rec_stat='0'
                           -- group by b.cust_name
                           -- where c.cust_bank_id='193'
                        )bc
                         left join ac_dis_cust a
on bc.cust_no=a.cust_no
--where a.cust_no= '1008749436'

select * from AC_DIS_BANK_CARD c

select bc.cust_name,bc.cust_no,bc.cust_bank_id,a.cust_tx_passwd,bc.rec_stat,
                       bc.id_no from (
                        select b.cust_name,b.cust_no,b.id_type,b.invst_type,
                                        b.id_no,c.cust_bank_id,c.rec_stat
                                         from ac_cust b left join  CP_CUST_BANK_ACCT_INFO c
                        on b.cust_no=c.cust_no
                           where c.rec_stat='0'
                       -- group by b.cust_name
                       -- where c.cust_bank_id='193'
                        )bc
                         left join ac_dis_cust a
on bc.cust_no=a.cust_no
where a.cust_no='1000001260'

select bc.cust_name,bc.cust_no,bc.cust_bank_id,a.cust_tx_passwd,bc.rec_stat,
                       bc.id_no from (
                       select b.cust_name,b.cust_no,b.id_type,b.invst_type,
                                        b.id_no,c.cust_bank_id,c.rec_stat
                                         from ac_cust b left join  CP_CUST_BANK_ACCT_INFO c
                        on b.cust_no=c.cust_no
                           where c.rec_stat='0'
                       
                       )bc


select * from BP_PIGGY_BANK_FUND_CFG

--query password
select b.cust_name, a.cust_no, a.cust_tx_passwd,b.id_no,b.id_type,b.invst_type from ac_dis_cust a 
left join ac_cust b
on a.cust_no=b.cust_no
where a.cust_no='1000000180'or a.cust_no='1000001024'
--group by b.cust_name

 
on b.cust_no=cj.cust_no
,ac_dis_cust k
where k.cust_no=cj.cust_no
--and rownum <=500

select distinct cust_name from ac_cust

select c.* from CP_CUST_BANK_ACCT_INFO c
where cust_bank_id='193'

select cust_tx_passwd from ac_dis_cust  where rownum <=500 
and cust_no='1000000180'
order by cust_no

--change password to 'qq1111'
update ac_dis_cust
set cust_tx_passwd='2bdba1e75fcec30dc812c90dbe89b253'
where cust_no='1000000214'

--'bb111111'
--NuWyL6dOOI3s+SokGNxGUIOWgm7WlRFoLPZVFeNgvl4w4/pnjmfvWritLSPtKXxqyoCMHmqsmBxAO4kr8wLs0A==
--9b78a7aa5c532706b781d945c46b31e0 1000000180
--594f6211771a86c6add012ecb3d130c8 1000000191


--查询有无丢单现象
--若储蓄罐存入成功，此表会产生对应交易信息
select * from tp_dis_tx_contract
order by app_dt desc
--where trade_dt='20150320'

select * from ac_dis_fund_tx_acct where cust_no = '1000000191'

select * from ac_dis_cust where cust_no='1000000191'


-- 验证储蓄罐存入 有无入库
select * from tp_dis_tx_contract tc where tc.contract_no='304200201501050114114776'


select * from tp_dis_tx_contract tc where app_dt='20150322'and app_tm='124900' 


select count(*) from leon_bk_dis_tx_contract

select count(*) from tp_dis_tx_contract where tx_code='209044'
 --209044 --209011 314 b2c
select count(*) from tp_dis_trade_app_rec

select * from tp_dis_trade_app_rec

delete from tp_dis_trade_app_rec;
delete from tp_dis_tx_contract;
select * from tp_dis_acct_app_rec 

drop table tp_dis_tx_contract;
drop table tp_dis_trade_app_rec;


ALTER table leon_bk_dis_tx_contract  rename to tp_dis_tx_contract 

ALTER table leon_bk_tp_dis_trade_app_rec rename to tp_dis_trade_app_rec 

20069
46965
alter table Bp_Fund_Discount add(acti_Flag VARCHAR2(1));
