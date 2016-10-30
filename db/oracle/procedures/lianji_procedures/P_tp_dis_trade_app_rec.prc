CREATE OR REPLACE PROCEDURE P_tp_dis_trade_app_rec(Count in number) IS
 
  V_DIS_APP_SERIAL_NO                      VARCHAR2(24);
  V_CONTRACT_NO                            VARCHAR2(24);
  V_CUST_NO	                               VARCHAR2(10);
  V_ID_NO                                  VARCHAR2(32);
  V_CUST_NAME                              VARCHAR2(180);
  V_FUND_TX_ACCT_NO                        VARCHAR2(17);
  --V_FUND_ACCT_NO                           VARCHAR2(12);
 
  V_BANK_ACCT                              VARCHAR2(30);
  V_DT                        VARCHAR2(8) := '20150308';
  V_INIT_CNT                  VARCHAR2(8) := '10000000';
  v_count                                  number;
 
BEGIN
  
   select Count - count(*) into v_count from lpt8_xm128_trade.tp_dis_trade_app_rec; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop
     
        select substr(SYS_GUID(),5,24) into V_DIS_APP_SERIAL_NO from DUAL;
        --dbms_output.put_line('guid: '|| V_M_UUID );
        
        V_CONTRACT_NO := V_DIS_APP_SERIAL_NO;
        V_CUST_NO := 'CN'||V_INIT_CNT;
        V_ID_NO := '3101041980'||V_INIT_CNT; 
        V_CUST_NAME := 'leon'||V_INIT_CNT;
        V_FUND_TX_ACCT_NO := '90410'||V_INIT_CNT;
        V_BANK_ACCT := '6222021510'||V_INIT_CNT;
        --V_FUND_ACCT_NO :=  '481311980347'||V_INIT_CNT;
        --V_SID := V_INIT_CNT;
        
        insert into lpt8_xm128_trade.tp_dis_trade_app_rec (
          DIS_APP_SERIAL_NO, CONTRACT_NO, TRADE_DT, APP_CODE,
          TX_CODE, CUST_NO, INVST_TYPE, ID_TYPE, 
          ID_NO, CUST_NAME, TX_APP_FLAG, TX_CHK_FLAG, 
          TX_ACK_FLAG, TX_PMT_FLAG, TX_COMP_FLAG, TRADE_CHAN, 
          REGION_CODE, OUTLET_CODE, BUSI_CODE, FUND_TX_ACCT_NO, 
          TA_CODE, FUND_ACCT_NO, FUND_CODE, SHARE_CLASS, 
          CURRENCY, APP_AMT, APP_VOL, TA_TRADE_DT, 
          APP_DT, APP_TM, TRADE_TM, COMB_NO, 
          CONS_CODE, RET_CODE, RET_MSG, CREATOR, 
          CHECKER, STIMESTAMP, LARGE_REDM_FLAG, REDM_FLAG, 
          ORI_APP_DT, ORI_APP_SERIAL_NO, VALID_PERIOD, ADVANCE_DAYS, 
          ADVANCE_DT, TA_SERIAL_NO, ORI_TA_SERIAL_NO, ORI_ACK_DT, 
          TAGENT_NO, TOUTLET_CODE, TREGION_CODE, TFUND_TX_ACCT_NO, 
          TFUND_CODE, TSHARE_CLASS, FEE_RATE, DIV_MODE, 
          DIV_RATIO, AGENT_DISC, TA_DISC, ACCT_PLAN_NO, 
          PLAN_CODE, CUST_BANK_ID, TM_UNIT, INTERVAL, 
          SAVING_PLAN_DT1, SAVING_PLAN_DT2, SAVING_PLAN_DT3, SAVING_PLAN_DT4, 
          FUND_RISK_LEVEL, CUST_RISK_LEVEL, RISK_FLAG, TRANSACTOR, 
          TRANSACTOR_ID_TYPE, TRANSACTOR_ID_NO, MEMO, PMT_URL, 
          PMT_RSLT, PMT_DT, PMT_TM, PMT_SERIAL_NO, 
          PMT_RET_CODE, PROTOCAL_END_DT, SAVING_TIMES, ADVANCE_FLAG, 
          BACKENLOAD_DISC, SHARE_REG_DT, DELAY_FLAG, SAVING_PLAN_NAME, 
          DIS_CODE, DIS_FUND_TX_ACCT_NO, PROTOCAL_NO, TRANS_RATIO, 
          TRANS_STATUS, IS_AUTO_REQUEST, REDM_LAST_VOL, TX_ACK_FLAG_BAK, 
          REDM_LAST_VOL_BAK, BLOTTER_NO, TRANS_RATIO_BAK, TRANS_STATUS_BAK,
          UPDATED_STIMESTAMP, LOANING_CHANNEL_ID, TRANSFER_LAST_VOL, TRANSFER_LAST_VOL_BAK,
          TFUND_ACCT_NO, BANK_REGION_NAME, BANK_ACCT, ACK_DT,
          FEE, BANK_CODE, FUND_ATTR, TAGENT_BANK_ID,
          TAGENT_DIS_CODE,TAGENT_PROTOCAL_NO,TAGENT_DIS_TX_ACCT_NO, TACK_VOL,
          DEAL_TYPE,ACK_VOL,ACK_AMT, UNUSUAL_TRANS_TYPE, 
          DIV_PER_UNIT,DRAW_BONUS_UNIT, REG_DT)
        values (
          V_DIS_APP_SERIAL_NO, V_CONTRACT_NO,V_DT, '20', 
          '202010', V_CUST_NO, '1', '0',
          V_ID_NO, V_CUST_NAME, '0', '0',
          '4', '2', '2', '5',
          'wap', 'W20130701', '022', V_FUND_TX_ACCT_NO,
          '48', '', '482002', 'A',
          '156', 300.00, 0.00, V_DT,
          V_DT,'010433', '093000', ' ',
          null, '0000', '交易成功(0000000)', 'HD0001',
          null, '21-7月 -14 01.04.33.234000 上午', null, null,
          null,null, 0, 0, 
          null,null, null, null, 
          null,null, null, null, 
          null,null, null, null, 
          null,1.0000, 1.0000, null,
          null,'161756', null, null, 
          null,null, null, null, 
          '1','1', '1', null, 
          null, null, null, null, 
          null, '20140721', '010433', null,
          '0000',null, null, '1', 
          null, null, null, null,
          'YYLC0B001','3041001829336YYLC0B001', '10000192974', '3',
          '3',null, 0.00000, '4',
          0.00000,null, '3', '3',
          '22-7月 -14 06.24.36.000000 下午', null, 0.00000, 0.00000,
          null, '赣州市南门支行', V_BANK_ACCT, V_DT,
          0.00000, '102', '工银货币', null,
          null, null, null, 0.00000,
          '1', 300.00000, 300.00000, '0', 
          0.00000, 0, null
        );

        V_INIT_CNT := V_INIT_CNT+1;
        
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
END P_tp_dis_trade_app_rec;
/
