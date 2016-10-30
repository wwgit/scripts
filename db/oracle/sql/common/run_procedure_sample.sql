declare

  -- Non-scalar parameters require additional processing 
  --discodes myvarry_list;
  --protocaltypes myvarry_list;
begin
   P_sp_cust_uuid(2494459);
end;
--expected 2494459
--existing 410351

begin
   P_bt_idno_verify_content(7927685);
end;
--expected 7927685
--existing 1269820

begin
   P_tp_dis_trade_app_rec(5863938);
end;
--expected 5863938
--existing 2573689

begin
   P_tp_dis_tx_contract(14309581);
end;
--expected 14309581
--existing 6432478

begin
   P_cp_cust_pmt_chnl_open(1707740);
end;
--expected 1707740
--existing 661557


begin
  P_ac_cust_login_stat_Proc(5000000);
end;
--expected 5000000
--existing 230054

begin
  P_sp_cust_uuid(2494459);
end;
--expected 2494459
--existing 410353

begin
   P_ac_corp_acct_bind(330850);
end;
--expected 330850
--existing 53480

begin
  P_bt_idno_verify_Proc(7927685);
end;
--expected 7927685
--existing 1270230

-------from ma cheng gong
begin
 P_ac_fund_bal_dtl_income_Proc(6362866);
 P_ac_dis_bal_income_Proc(3052329);
 P_ac_cust_Proc(7428405);
 P_ac_fund_tx_acct_Proc(7428405);
 
end;

begin
   P_as_dis_fund_bal_frz_Proc(8587);
end;


begin
 P_ac_white_list(3000);
 P_ac_piggy_frz(10900000);
 P_ac_piggy_vol(8700000);
 P_his_deal_dtl_more_90(6750000);
 P_his_deal_more_90(7200000);
 P_his_trade_dtl_more_90(6750000);
 P_tp_deal(11500000);
 P_tp_deal_dtl(11500000);
 P_tp_deal_acct_app(1960000);
 P_tp_trade_deal(24000000);
 
end;


-- gu ji 

begin
   P_tp_dis_trade_app_rec(19036785);
   P_his_fund_nav_Proc(195042);
   P_ac_piggy_income_Proc(1545818);
   P_ac_fund_bal_dtl_income_Proc(6362866);
   P_ac_dis_bal_income_Proc(3052329);
   P_ac_dis_cust_Proc(7047111);
   P_ac_fund_acct_bal_dtl_Proc(5728421);
   P_dis_trade_plan_Proc(8693893);
   P_ac_dis_bank_card_Proc(3519525);
end;

begin
   P_ac_dis_fund_acct_bal_Proc(3052341);
   P_cp_cust_bank_acct_info_Proc(3674029);
   P_ac_cust_Proc(7428405);
   P_ac_fund_tx_acct_Proc(7428405);
   P_ac_dis_fund_tx_acct_Proc(7736831);
   P_ac_acct_div_mode_Proc(102486);
   P_his_piggy_income_Proc(73934094);
end;
