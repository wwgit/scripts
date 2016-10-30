CREATE OR REPLACE PROCEDURE P_tp_dis_acct_app_rec(Count in number) IS
 
  V_DIS_APP_SERIAL_NO                      VARCHAR2(24);
  V_CONTRACT_NO                            VARCHAR2(24);
  v_count                                  number;
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.tp_dis_acct_app_rec; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop
     
        select substr(SYS_GUID(),5,24) into V_DIS_APP_SERIAL_NO from DUAL;
        --dbms_output.put_line('guid: '|| V_M_UUID );
        
        V_CONTRACT_NO := V_DIS_APP_SERIAL_NO;

        insert into lct_xm128_trade.TP_DIS_ACCT_APP_REC (
        DIS_APP_SERIAL_NO, CONTRACT_NO, TRADE_DT, APP_CODE,
         TX_CODE, CUST_NO, INVST_TYPE, ID_TYPE,
         ID_NO, CUST_NAME, TX_APP_FLAG, TX_CHK_FLAG,
         TX_ACK_FLAG, TX_PMT_FLAG, TX_COMP_FLAG, TRADE_CHAN,
         REGION_CODE, OUTLET_CODE, BUSI_CODE, FUND_TX_ACCT_NO,
         FUND_ACCT_NO, TA_CODE, TA_TRADE_DT, APP_DT,
         APP_TM, TRADE_TM, CAPT_ACCT_ID, CAPT_ACCT_BANK_CODE,
         CAPT_ACCT_REGION_CODE, CAPT_ACCT_REGION_NAME, CAPT_ACCT, CAPT_ACCT_NAME,
         CAPT_ACCT_TYPE, CAPT_ACCT_ATTR, PMT_STAT, CURRENCY,
         IS_DFLT, CAPT_VRFY_STAT, CAPT_VRFY_MODE, PAY_NO,
         BROKER_CODE, CONS_CODE, INTR_CUST_NO, ACT_CODE,
         RET_CODE, RET_MSG, CREATOR, CHECKER,
         CUST_ABBR, POST_CODE, ADDR, TEL_NO,
         CUST_TYPE, EMAIL, PAGER_NO, FAX,
         FAX_FLAG, HOME_TEL_NO, OFFICE_TEL_NO, MOBILE,
         EDU_LEVEL, VOCATION, INC_LEVEL, BIRTHDAY,
         GENDER, FUND_MAN_DLVY_TYPE, FUND_MAN_DLVY_MODE,
         AGENT_DLVY_TYPE, AGENT_DLVY_MODE, CONF_DOC_NO, SECU_SH_ACCT_NO,
         SECU_SZ_ACCT_NO, MINOR_FLAG, MINOR_ID, CORP_CODE,
         FRZN_CAUSE, FRZN_DEADLINE, FRZN_DESC, PROV_CODE,
         CITY_CODE, AGENT_STAT, VRFY_NO, LINK_MAN_ID,
         LINK_MAN_TYPE, LINK_MAN, LINK_ID_TYPE, LINK_ID_NO,
         LINK_METHOD, LINK_TEL, LINK_MOBILE, LINK_EMAIL,
         LINK_POST_CODE, LINK_ADDR, SPECIAL_CODE_LIST, OPEN_MODE,
         ID_VRFY_STAT, ID_VRFY_MODE, ETX_STAT, CTX_STAT,
         USER_ID, PASSWD_SEND_TYPE, STIMESTAMP, CUST_RISK_LEVEL,
         TOTAL_WP, ANSWER_XML, COMPANY, ID_VALIDITY_START,
         ID_VALIDITY_END, ID_ALWAYS_VALID_FLAG, LINK_ID_VALIDITY_START, LINK_ID_VALIDITY_END,
         LINK_ID_ALWAYS_VALID_FLAG, CAPT_BIND_STAT, TRANSACTOR, TRANSACTOR_ID_TYPE,
         TRANSACTOR_ID_NO, CORP_ID_TYPE, CORP_ID_NO, CORPORATION,
         NATIONALITY, MARRIAGE_STAT, SECU_INVEST_EXP, PMT_CUST_NO,
         REG_ADDR, REG_POST_CODE, CORP_ID_ALWAYS_VALID_FLAG, CORP_ID_VALIDITY_END,
         CORP_ACCT_NO, IDENTIFY_MODE, DIS_CODE, DIS_FUND_TX_ACCT_NO,
         PROTOCAL_NO, TRANS_RATIO, TRANS_STATUS, TX_ACK_FLAG_BAK,
         TRANS_RATIO_BAK, TRANS_STATUS_BAK, UPDATED_STIMESTAMP, DEAL_TYPE,
         ACK_DT, CUST_LETTER_FLAG
         )
        values (
        V_DIS_APP_SERIAL_NO, V_DIS_APP_SERIAL_NO, '20141217', '20',
         '203110', '1008749470', '1', '0',
         '110101198001019971', '身为台湾', '0', '0',
         '0', '0', '0', '2',
         'web', 'WEB000001', '325', '3041008808194',
         null, null, '20141218', '20151120',
         '180251', '093000', null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         '0000', null, 'web', null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, '20-11月-15 06.02.51.740000 下午', null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, null, null, null,
         null, 'HB000A001', '3041008808194HB000A001', null,
         null, '3', null, null,
         null, null, '2', null,
         null
         );
        
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
END P_tp_dis_acct_app_rec;
/
