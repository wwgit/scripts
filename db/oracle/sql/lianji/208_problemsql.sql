select taTradeDt,
       tradeBal,
       txAppFlag,
       txAckFlag,
       txPmtFlag,
       transRatio,
       transStatus,
       tradeType,
       contractNo,
       tradeDt,
       tradeTm,
       divFlag,
       txCode,
       busiCode,
       transStatusBak,
       bankAcct,
       bankName,
       bankCode,
       pmtDt,
       ackDt,
       prodId,
       prodName
  from (select t.ta_trade_dt as taTradeDt,
               (CASE t.tx_code
                 WHEN '209011' THEN
                  (CASE
                    when nvl(ack.ack_amt, 0) = 0 then
                     t.app_amt
                    when nvl(ack.ack_amt, 0) > ack.ack_vol then
                     ack.ack_amt
                    else
                     t.app_amt
                  END)
                 WHEN '209014' THEN
                  (CASE
                    when nvl(ack.ack_amt, 0) = 0 then
                     t.app_vol
                    when nvl(ack.ack_amt, 0) > ack.ack_vol then
                     ack.ack_amt
                    else
                     t.app_vol
                  END)
                 WHEN '209012' THEN
                  (CASE
                    when nvl(ack.ack_amt, 0) = 0 then
                     t.app_vol
                    when nvl(ack.ack_amt, 0) > ack.ack_vol then
                     ack.ack_amt
                    else
                     t.app_vol
                  END)
                 WHEN '209013' THEN
                  (CASE
                    when nvl(ack.ack_amt, 0) = 0 then
                     t.app_vol
                    when nvl(ack.ack_amt, 0) > ack.ack_vol then
                     ack.ack_amt
                    else
                     t.app_vol
                  END)
               END) tradeBal,
               t.tx_app_flag as txAppFlag,
               t.tx_ack_flag as txAckFlag,
               t.tx_pmt_flag as txPmtFlag,
               t.trans_ratio as transRatio,
               t.trans_status as transStatus,
               (CASE t.tx_code
                 WHEN '209011' THEN
                  '1'
                 WHEN '209012' THEN
                  '2'
                 WHEN '209013' THEN
                  '2'
                 WHEN '209014' THEN
                  '4'
               END) tradeType,
               t.contract_no as contractNo,
               t.app_dt as tradeDt,
               t.app_tm as tradeTm,
               '0' as divFlag,
               t.tx_code as txCode,
               t.busi_code as busiCode,
               t.trans_status_bak as transStatusBak,
               t.bank_acct as bankAcct,
               t.bank_region_name as bankName,
               t.bank_code as bankCode,
               t.pmt_dt as pmtDt,
               t.ack_dt as ackDt,
               t.prod_id as prodId,
               t.prod_name as prodName
          from (tp_dis_trade_app_rec) t
          left join (select *
                      from tp_dis_trade_app_rec
                     where busi_code = '024'
                       and cust_no = ?) ack
            on t.contract_no = ack.contract_no
         where t.tx_app_flag <> '1'
           and t.Dis_Code = ?
           and t.tx_code in ('209011', '209012', '209013', '209014')
           and t.cust_no = '1001029520'
        union all
        select v.trade_dt as taTradeDt,
               v.ack_vol as tradeBal,
               '' as txAppFlag,
               '' as txAckFlag,
               '' as txPmtFlag,
               '' as transRatio,
               '' as transStatus,
               '3' as tradeType,
               v.DIS_APP_SERIAL_NO as contractNo,
               v.ack_dt as tradeDt,
               '' as tradeTm,
               '1' as divFlag,
               '' as txCode,
               v.busi_code as busiCode,
               '' as transStatusBak,
               v.bank_acct as bankAcct,
               v.bank_region_name as bankName,
               v.bank_code as bankCode,
               v.pmt_dt as pmtDt,
               v.ack_dt as ackDt,
               v.prod_id as prodId,
               v.prod_name as prodName
          from (select *
                  from tp_dis_trade_app_rec
                 where cust_no = ?
                   and busi_code in ('143', '443')
                   and ret_code = '0000') v,
               ac_dis_acct_trade_plan plan
         where v.dis_fund_tx_acct_no = plan.dis_fund_tx_acct_no
           and v.protocal_no = plan.protocal_no
           and plan.protocal_type = '3'
           and v.dis_code = ?
           and v.cust_no = '1001029520') rs
 order by tradeDt desc, tradeTm desc
