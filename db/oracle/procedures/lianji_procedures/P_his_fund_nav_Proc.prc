CREATE OR REPLACE PROCEDURE P_his_fund_nav_Proc(Count in number) IS
 
  v_fund_code VARCHAR2(6);
  v_nav_date  VARCHAR2(8);
--  v_init_cnt  VARCHAR2(5) := '10001';
  v_count     number;
 -- v_month     number(8);
 
BEGIN
  
   select Count - count(*) into v_count from lpt5_xm128_trade.his_fund_nav;
   select TO_CHAR(sysdate,'yyyymmdd') into v_nav_date from DUAL;
        
   for i in 1 .. v_count loop
     
     SELECT substr(SYS_GUID(),4,6) INTO v_fund_code FROM DUAL;
     select TO_CHAR(ADD_MONTHS(LAST_DAY(TO_DATE(v_nav_date,'yyyymmdd'))+1,-2),'yyyymmdd') into v_nav_date from dual;
      
     -- dbms_output.put_line(v_fund_code);
      insert into his_fund_nav (FUND_CODE, NAV_DATE, MAIN_FUND_CODE, FUND_TYPE, 
      FUND_STAT, NAV, FUND_INC, UPDATED_STATUS, 
      STIMESTAMP, SEVEN_YEAR_RATE, IS_REDE, IS_SUBS, 
      IS_SAVINGPLAN, IS_HB_SAVINGPLAN)
      values (v_fund_code,v_nav_date, '485118', '2', 
      null, 1.000000, 1.36750, '0', 
      '25-3月 -14 08.40.24.000000 下午', null, null, null, 
      null, null);
     -- v_init_cnt := v_init_cnt+1;
      if (mod(i, 2000) = 0) then
        --dbms_output.put_line('已经执行了'||i||'个客户');
        
      --  SELECT substr(SYS_GUID(),4,6) INTO v_fund_code FROM DUAL;
        commit;
      end if;
  end loop;
  commit;

exception
    when others then
      dbms_output.put_line('exception------');
      DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode);
      DBMS_OUTPUT.put_line('sqlerrm : ' ||sqlerrm);
      rollback;
END P_his_fund_nav_Proc;
/
