SELECT DISTINCT (cp.bank_code)
           FROM cp_cust_bank_acct_info cp
          WHERE EXISTS (
                   SELECT 1
                     FROM ac_dis_bank_card ad
                    WHERE ad.cust_bank_id = cp.cust_bank_id
                      AND ad.is_valid = '1'
                      AND ad.pay_sign = '2'
                      AND ad.cust_no = '1000000821'
                      AND ad.dis_code = 'null')

