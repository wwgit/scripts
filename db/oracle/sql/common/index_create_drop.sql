select count(*) from AS_PIGGY_FRZ t
select count(*) from ac_acct_saving_plan
select count(*) from AC_DIS_ACCT_TRADE_PLAN

--0206
Create index idx_as_piggy_frz_appdt on AS_PIGGY_FRZ (app_dt);
Create index idx_as_piggy_frz_discode on AS_PIGGY_FRZ (dis_code);

--0112
Create index idx_saving_plan_protocal_no on ac_acct_saving_plan (protocal_no);
Create index idx_saving_plan_fund_code on ac_acct_saving_plan (fund_code);
--Create index idx_saving_plan_cust_no on ac_acct_saving_plan (cust_no);
Create index idx_ACCT_TRADE_PLAN on AC_DIS_ACCT_TRADE_PLAN(cust_no);

Drop index idx_as_piggy_frz_appdt
Drop index idx_as_piggy_frz_discode
Drop index idx_saving_plan_cust_no



select status from user_indexes idx_as_piggy_frz_appdt where table_name = 'AS_PIGGY_FRZ'

 
