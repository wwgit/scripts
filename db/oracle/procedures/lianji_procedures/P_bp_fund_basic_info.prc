CREATE OR REPLACE PROCEDURE P_bp_fund_basic_info(Count in number) IS
 
  V_FUND_CODE                                VARCHAR2(6);
  v_count                                    number;
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.bp_fund_basic_info;
   select max(fund_code) into V_FUND_CODE from lct_xm128_trade.bp_fund_basic_info;
   V_FUND_CODE:= TO_CHAR(TO_NUMBER(V_FUND_CODE,'999999')+1);
    
    dbms_output.put_line('当前最大fund_code: '||V_FUND_CODE);
   
   for i in 1 .. v_count loop
             
        insert into lct_xm128_trade.BP_FUND_BASIC_INFO (
        FUND_CODE, FUND_NAME, TA_CODE, FUND_MAN_CODE,
         CATEGORY_ID, CURRENCY, DFLT_DIV_MODE, CHG_TRUSTEE_MODE,
         START_TM, END_TM, SUPPLE_SUBS_RULE, FACE_VALUE,
         FEE_CAL_MODE, MIN_ACCT_VOL, FUND_RISK_LEVEL, REC_STAT,
         CHECK_FLAG, CREATOR, MODIFIER, CHECKER,
         CRE_DT, MOD_DT, FUND_TYPE, FUND_ATTR_PINYIN,
         IPO_END_TM, MAIN_FUND_CODE, DISTRIBUTE_SIZE, IPO_START_DT,
         IPO_END_DT, ESTABLISH_DT, FUND_CUSTODIAN_CODE, FUND_ATTR,
         PART_CODE, FUND_ATTR_HB, FUND_SUB_TYPE, REDE_OPEN_TERM,
         SUMMARY, FUND_OPEN_MODE, YIELD_TYPE, RECOMM_INFO,
         FUND_STAT_PRESET_DAYS, SETTLE_TYPE, OPEN_DT, OPEN_FLAG,
         FUND_CLASS, DIV_GROUP_CODE
         )
        values (
        V_FUND_CODE, '预埋基金', '99', '999',
         null, '156', '1', '1',
         '093000', '150000', '111', 1.00000,
         '0', 1000000.00000, '4', '0',
         '1', 'ying.chen', 'ying.chen', 'jiaping.zhang',
         '20131022', '20131126', '1', 'stzxdlhh',
         '170000', '000328', null, '20131024',
         '20131120', null, '005', '预埋数据',
         'TA99', '预埋数据', null, null,
         null, null, null, null,
         null, '0', null, '1',
         '2', null
         );
         V_FUND_CODE:= TO_CHAR(TO_NUMBER(V_FUND_CODE,'999999')+1);
        
         if (mod(i, 2000) = 0) then
            --dbms_output.put_line('已经执行了'||i||'个客户');
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
END P_bp_fund_basic_info;
/
