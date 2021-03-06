select DEAL_NO,
       TX_CODE,
       DEAL_TYPE,
       DEAL_STAT,
       VOL_OK,
       CUST_NO,
       CUST_NAME,
       CUST_BANK_ID,
       ID_TYPE,
       ID_NO,
       BANK_ACCT,
       BANK_CODE,
       PRODUCT_CODE,
       PRODUCT_NAME,
       APP_DT,
       APP_TM,
       APP_AMT,
       APP_VOL,
       SYS_TRADE_DT,
       PD_TRADE_DT,
       INVST_TYPE,
       TRADE_CHAN,
       OUTLET_CODE,
       CONS_CODE,
       TRANSACTOR,
       TRANSACTOR_ID_TYPE,
       TRANSACTOR_ID_NO,
       DIS_CODE,
       DIS_FUND_TX_ACCT_NO,
       PROTOCAL_NO,
       TX_IP,
       CORP_DEAL_NO,
       PIGGY_PAY_DEAL_NO,
       PIGGY_PAY_PNO,
       PIGGY_PAY_PNM,
       PIGGY_PAY_PTP,
       RET_CODE,
       RET_MSG,
       ACTIVE_NAME,
       MEMO,
       CREATOR,
       MODIFIER,
       CHECKER,
       CRE_DT,
       MOD_DT,
       CHECK_FLAG,
       STIMESTAMP,
       UPDATED_STIMESTAMP
  from TP_DEAL
 where REQUEST_ID <> ''
   AND TRADE_CHAN <> ''



alter table TP_DEAL add request_id varchar2(50);
