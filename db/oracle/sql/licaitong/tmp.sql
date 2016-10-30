select * from BP_DIS

select * from BP_OUTLET

select count(*) from ac_cust;
select count(*) from ac_dis_cust;
select count(*) from AC_FUND_TX_ACCT;
select count(*) from AC_DIS_FUND_TX_ACCT;
select count(*) from AC_CORP_ACCT_BIND;
select count(*) from AC_DIS_ACCT_TRADE_PLAN;
select count(*) from CP_CUST_BANK_ACCT_INFO;
select count(*) from AC_DIS_BANK_CARD;

select count(*) from TP_DIS_TX_CONTRACT;
select count(*) from TP_DIS_ACCT_APP_REC;
select count(*) from BP_FUND_BASIC_INFO;
select count(*) from AC_CROP_TRADE_REC;
select count(*) from BP_LCT_FUND_CFG;
select count(*) from BP_FUND_SHARE_CLASS;

select count(*) from SP_ACCT_STATUS_TX_CFG;
select count(*) from BP_FUND_TX_OPEN_CFG;
select count(*) from CP_SETTLE_DT_CFG;
select count(*) from BP_FUND_NAV_STATUS;
select count(*) from BP_FUND_LIMIT;
select count(*) from AC_FUND_ACCT;
select count(*) from AC_DIS_FUND_ACCT_BAL;


select * from BP_FUND_TX_OPEN_CFG;
select * from CP_SETTLE_DT_CFG;
select * from BP_FUND_NAV_STATUS;
select * from BP_FUND_LIMIT; 
select * from AC_FUND_ACCT;
select * from AC_DIS_FUND_ACCT_BAL;

begin
  --P_ac_cust_Proc(7428405);
  --P_ac_dis_cust_Proc(7047111);
 -- P_ac_fund_tx_acct_Proc(7428405);
 -- P_ac_dis_fund_tx_acct_Proc(7736831);
 -- P_ac_corp_acct_bind(7428405);
 --P_dis_trade_plan_Proc(8693893);
 --P_cp_cust_bank_acct_info_Proc(3674029);
 --P_ac_dis_bank_card_Proc(3519525);
 --P_tp_dis_tx_contract(46999935);
 --P_tp_dis_acct_app_rec(17979042);
 --P_bp_fund_basic_info(2475);
 --P_AC_CROP_TRADE_REC(46999935);
 --P_bp_lct_fund_cfg(50);
 --P_bp_fund_share_class(100);
 --P_bp_fund_tx_open_cfg(100);
 --P_cp_settle_dt_cfg(18955);
  --P_bp_fund_nav_status(100);
  --P_bp_fund_limit(300);
  --P_ac_fund_acct(1000);
  P_ac_dis_fund_acct_bal_Proc(100);
end;

delete from bp_fund_basic_info
where fund_name = 'Ф¤Вс»щЅр'
