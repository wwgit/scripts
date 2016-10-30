explain plan 
set statement_id='fast_frzn_amt_sum'
for select nvl(sum(aspiggyfrz0_.FAST_FRZN_AMT), 0) as col_0_0_ 
from AS_PIGGY_FRZ aspiggyfrz0_ 
where aspiggyfrz0_.DO_FRZN_STAT='0'  
and aspiggyfrz0_.DIS_CODE=:1 and aspiggyfrz0_.APP_DT>=:2

explain plan 
set statement_id='piggy_frz_query'
for select * from As_Piggy_Frz

select * from table(dbms_xplan.display);
