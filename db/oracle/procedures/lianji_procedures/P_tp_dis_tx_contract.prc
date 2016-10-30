CREATE OR REPLACE PROCEDURE P_tp_dis_tx_contract(Count in number) IS
 
  --V_DIS_APP_SERIAL_NO                      VARCHAR2(24);
  V_CONTRACT_NO                            VARCHAR2(24);
  V_CUST_NO                                 VARCHAR2(10);
  V_ID_NO                                  VARCHAR2(32);
  V_CUST_NAME                              VARCHAR2(180);
  V_FUND_TX_ACCT_NO                        VARCHAR2(17);
  V_FUND_ACCT_NO                           VARCHAR2(12);
 
  V_BANK_ACCT                              VARCHAR2(30);
  V_DT                        VARCHAR2(8) := '20150308';
  V_INIT_CNT                  VARCHAR2(8) := '10000000';
  v_count                                  number;
 
BEGIN
  
   select Count - count(*) into v_count from lct_xm128_trade.tp_dis_tx_contract; 
    --dbms_output.put_line(v_count);
   
   for i in 1 .. v_count loop
     
        select substr(SYS_GUID(),5,24) into V_CONTRACT_NO from DUAL;
        --dbms_output.put_line('guid: '|| V_M_UUID );
        
        V_CUST_NO := 'CN'||V_INIT_CNT;
        V_ID_NO := '3101041980'||V_INIT_CNT; 
        V_CUST_NAME := 'leon'||V_INIT_CNT;
        V_FUND_TX_ACCT_NO := '90410'||V_INIT_CNT;
        V_BANK_ACCT := '62215092400'||V_INIT_CNT;
        V_FUND_ACCT_NO :=  '5813'||V_INIT_CNT;
        --V_SID := V_INIT_CNT;
        
       insert into lct_xm128_trade.tp_dis_tx_contract (
            CONTRACT_NO, TRADE_DT, APP_CODE, TX_CODE,
            CUST_NO, INVST_TYPE, ID_TYPE, ID_NO,
            CUST_NAME, TX_APP_FLAG, TX_CHK_FLAG, TX_ACK_FLAG,
            TX_PMT_FLAG, TX_COMP_FLAG, TRADE_CHAN, REGION_CODE,
            OUTLET_CODE, BUSI_CODE, FUND_TX_ACCT_NO, TA_CODE,
            FUND_ACCT_NO, APP_AMT, APP_VOL, TA_TRADE_DT,
            APP_DT, APP_TM, TRADE_TM, CUST_BANK_ID,
            PMT_MODE, VOUCH_NO, CURRENCY, CONS_CODE,
            ACCT_PLAN_NO, ORI_CONTRACT_NO, VALID_PERIOD, ADVANCE_DAYS,
            ADVANCE_DT, RET_CODE, RET_MSG, CREATOR,
            CHECKER, MEMO, STIMESTAMP, TRANSACTOR,
            TRANSACTOR_ID_TYPE, TRANSACTOR_ID_NO, PMT_URL, PMT_RSLT,
            PMT_DT, PMT_TM, PMT_SERIAL_NO, PMT_RET_CODE,
            DEAL_NO, PMT_INST_CODE, PMT_TX_FEE, PMT_MANAGER_FEE,
            ADVANCE_FLAG, DIS_CODE, DIS_FUND_TX_ACCT_NO, PROTOCAL_NO,
            TRANS_RATIO, TRANS_STATUS, TRANS_RATIO_BAK, TRANS_STATUS_BAK,
            TX_IP, DEAL_TYPE, BANK_REGION_NAME, BANK_ACCT,
            MER_DEAL_NO, BANK_CODE, UNUSUAL_TRANS_TYPE,PEOPLE_PROC_FLAG, 
            PROC_FLAG, APP_DTM, PAY_DTM,ACK_DTM, 
            CANCEL_DTM
         )
        values (
          V_CONTRACT_NO,V_DT, '20', '209011',
          V_CUST_NO, '1', '0',V_ID_NO,
          V_CUST_NAME, '3', '4', '0',
          '1', '0', '1', '1',
          'GSH000001', '022',V_FUND_TX_ACCT_NO, '48',
          V_FUND_ACCT_NO, 20.00, 0.00, '20140909',
          '20140909', '133700', '133700', '213300',
          null, null, '156', null,
          null, null, 0, 0, 
          null,'0000', null, 'ying.chen', 
          'ruijie.chen',null, '18-6月 -14 06.44.30.645000 下午', null, 
          null,null, null, null, 
          null,null, null, null, 
          null,null, null, null, 
          '0','HB000A001', '3041002475031HB000A001', '30000372308', 
          null,'1', null, '1', 
          null,'3', '抚顺市北站支行', '6221502240000060252', 
          null,'403', '0', null, 
          '1','09-9月 -14 01.37.00.000000 下午', null, null, 
          null
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
END P_tp_dis_tx_contract;
/
