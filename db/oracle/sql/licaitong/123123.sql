select ab.* from ac_dis_fund_tx_acct c left join (
              select a.cust_no,a.cust_name,a.id_no,a.id_type, 
                     b.dis_cust_id,
                     d.corp_acct_no,corp_inst_code,corp_acct_bind_stat,
                     t.dis_code,t.fund_tx_acct_no,t.cust_bank_id,t.pay_sign,t.fund_acct_stat
              from ac_cust a left join ac_dis_cust b 
                   on a.cust_no = b.cust_no 
              left join ac_corp_acct_bind d 
                   on a.cust_no = d.cust_no
              right join 
                ( select distinct tt.cust_no,tt.fund_tx_acct_no,tt.cust_bank_id,tt.pay_sign,tt.dis_code,ff.fund_acct_stat 
                  from AC_DIS_BANK_CARD tt left join ac_fund_acct ff
                       on tt.fund_tx_acct_no = ff.fund_tx_acct_no
                       where tt.is_valid = '1'
                      -- and ff.fund_acct_stat = '0' --ac_fund_acct �����˺�״̬������                  
                )t --AC_DIS_BANK_CARD ��Ч
                on a.cust_no = t.cust_no
                  -- and t.pay_sign = '2'   --AC_DIS_BANK_CARD  ����ǩԼ״̬���ѿ�ͨ
                  -- and t.bank_card_cancel_dt is null -- AC_DIS_BANK_CARD ���п�ע������Ϊ��
              )ab
on ab.cust_no = c.cust_no
where 
--ab.cust_name like 'walterwhite%' and
c.fund_tx_acct_stat = '0' and --��������
ab.corp_acct_bind_stat = '2' -- �Ѱ�
