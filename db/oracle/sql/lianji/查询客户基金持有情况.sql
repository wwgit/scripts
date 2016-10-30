select  vw.* , bp.* , fm.* , ai.* , bt.* , bc.* 
  from (select vbal.cust_no,
       --add
       dis.dis_name,
       --add
       vbal.dis_code,
       vbal.dis_fund_tx_acct_no,vbal.protocal_no,vbal.fund_tx_acct_no,vbal.fund_acct_no,vbal.div_mode,vbal.div_ratio,
       vbal.ta_code,vbal.today_avail_vol,vbal.today_frzn_vol,vbal.fund_code,vbal.share_class,vbal.balance_vol,
       vbal.avail_vol,vbal.frzn_vol,vbal.just_frzn_vol,vbal.reg_dt,vbal.ud_dt,nvl(info.fund_attr, info.fund_name) as fund_abbr,
       --add1
       nav1.nav,nav1.nav_date,nav1.fund_stat,
       --nav1.pd_subs_stat,
       (select stat.pd_subs_stat from bp_fund_nav_status stat
         where stat.fund_code = vbal.fund_code and stat.trade_dt = nav1.nav_date) as pd_subs_stat,
       (vbal.balance_vol * nav1.nav) as total_amt,bank.cust_bank_id as cust_bank_id,bank.bank_code,bank.bank_acct, bank.bank_region_name,
       --add1
       info.fund_man_code,info.fund_type, decode(ex.fund_code, null, '0', '1') as chg_trustee_mode,fundman.fund_man_name,
       vbal.protocal_type,aasp.memo,aasp.acct_plan_id
    from (
         select tx.cust_no,tx.fund_tx_acct_stat as fund_tx_acct_stat,
         nvl(dm.div_mode,basc.dflt_div_mode) as div_mode,dm.div_ratio as div_ratio,
         --basc.ta_code as ta_code,
         (nvl(t.avail_vol,0)-nvl(fz.today_frzn_vol,0)) as today_avail_vol,
         (nvl(t.frzn_vol,0)+nvl(fz.today_frzn_vol,0)+nvl(t.just_frzn_vol,0)) as today_frzn_vol,
         p.protocal_type,t.*
      from (
           select * from ac_dis_fund_acct_bal
           where fund_tx_acct_no = '3041000007164'
      ) t
      left join ac_acct_div_mode dm
      on t.fund_tx_acct_no = dm.fund_tx_acct_no
      and t.fund_code = dm.fund_code
      and t.fund_acct_no = dm.fund_acct_no
      and t.share_class = dm.share_class
      left join bp_fund_basic_info basc on t.fund_code = basc.fund_code
      left join ac_dis_fund_tx_acct tx on t.dis_fund_tx_acct_no = tx.dis_fund_tx_acct_no
      left join (
                select tfz.dis_fund_tx_acct_no,tfz.fund_acct_no,tfz.fund_code,tfz.share_class,tfz.protocal_no,tfz.cust_bank_id,sum(tfz.today_frzn_vol) as today_frzn_vol
                from (
                 select * from as_dis_fund_bal_frz where fund_tx_acct_no = '3041000007164'
                ) tfz
                group by (tfz.dis_fund_tx_acct_no,tfz.fund_acct_no,tfz.fund_code,tfz.share_class,tfz.protocal_no,tfz.cust_bank_id)
                ) fz on t.dis_fund_tx_acct_no = fz.dis_fund_tx_acct_no and t.fund_acct_no = fz.fund_acct_no
                                and t.fund_code = fz.fund_code and t.share_class = fz.share_class and t.protocal_no = fz.protocal_no and t.cust_bank_id = fz.cust_bank_id
      left join(
           select * from AC_DIS_ACCT_TRADE_PLAN
      ) p on t.protocal_no=p.protocal_no and t.dis_fund_tx_acct_no=p.dis_fund_tx_acct_no
    
    ) vbal
    --add2
    left join BP_DIS dis
      on vbal.dis_code = dis.dis_code
    left join bt_fund_nav nav1
      on nav1.fund_code = vbal.fund_code
    left join CP_CUST_BANK_ACCT_INFO bank
      on vbal.cust_no = bank.cust_no
     and vbal.cust_bank_id = bank.cust_bank_id
     and bank.bank_acct_status = '0'
     and bank.bank_acct_bind_stat = '3'
     --add2
    left join BP_FUND_BASIC_INFO info
      on vbal.fund_code = info.fund_code
    left join BP_FUND_MAN fundman
      on fundman.fund_man_code = info.fund_man_code
    left join (select t1.out_fund_code fund_code
                 from bp_fund_ex_cfg t1
                where t1.rec_stat = '0'
                  and t1.check_flag = '1'
               union
               select t2.in_fund_code fund_code
                 from bp_fund_ex_cfg t2
                where t2.rec_stat = '0'
                  and t2.check_flag = '1'
                  and t2.conv_flag = '1') ex
      on ex.fund_code = vbal.fund_code
      left join(
           select * from ac_acct_saving_plan
      )aasp on vbal.protocal_no=aasp.protocal_no and aasp.rec_stat='0' and aasp.acct_plan_stat='0'
  ) vw
  left join bp_fund_basic_info bp on vw.fund_code = bp.fund_code
  left join bp_fund_man fm on vw.fund_man_code = fm.fund_man_code
  left join ac_dis_fund_acct_bal_income ai 
       on vw.dis_fund_tx_acct_no = ai.dis_fund_tx_acct_no
          and vw.fund_code = ai.fund_code
          and vw.protocal_no =ai.protocal_no
          and vw.share_class =ai.share_class
          and vw.cust_bank_id = ai.cust_bank_id
  left join bt_fund_nav bt on vw.fund_code = bt.fund_code
  left join ( 
  select * from bp_fund_tx_open_cfg where open_flag = '1'
  and rec_stat = '0'
  and check_flag = '1'
  and tx_code = '202080'
  ) bc 
  on  (bc.ta_code = vw.ta_code or bc.ta_code = '**')
  and (bc.fund_code = vw.fund_code or bc.fund_code = '******'),
 (select * from ac_dis_acct_trade_plan ) p
 where vw.protocal_no = p.protocal_no
   and vw.balance_vol > 0
   and vw.fund_type <> '7'
