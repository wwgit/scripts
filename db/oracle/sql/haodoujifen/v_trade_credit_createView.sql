create or replace view v_trade_credit as
select
       --t.username as username, --ÓÃ»§Ãû
       t3.cre_dt,
       t3.SERIAL_NO,
       t3.access_type,
       t3.task_id,
       t3.score,
       t3.tradevol,
       t3.state_type,
       t3.acct_no,
       t3.id_type
from  /*cm_usertrustship t,
      sync_ac_fund_tx_acct t1 ,
      sync_ac_cust t2,*/
      cm_web_user_acct_access t3
/*where
      t3.acct_no=t2.id_no
      and t.trustshipusername=t1.fund_tx_acct_no
      and t1.cust_no=t2.cust_no
      and t.trustshiptype='1'
      and t.trustshipstatus = '1'*/
      order by t3.cre_dt desc;
