SELECT this_.cust_no AS cust1_251_0_, this_.cust_name AS cust2_251_0_,
       this_.invst_type AS invst3_251_0_, this_.id_type AS id4_251_0_,
       this_.id_no AS id5_251_0_, this_.id_validity_start AS id6_251_0_,
       this_.id_validity_end AS id7_251_0_,
       this_.id_always_valid_flag AS id8_251_0_,
       this_.birthday AS birthday251_0_, this_.gender AS gender251_0_,
       this_.cust_stat AS cust11_251_0_, this_.corp_id_no AS corp12_251_0_,
       this_.corp_id_type AS corp13_251_0_,
       this_.corporation AS corpora14_251_0_, this_.can_dt AS can15_251_0_,
       this_.corp_id_always_valid_flag AS corp16_251_0_,
       this_.corp_id_validity_end AS corp17_251_0_,
       this_.id_vrfy_stat AS id18_251_0_, this_.reg_dt AS reg19_251_0_,
       this_.reg_outlet_code AS reg20_251_0_,
       this_.reg_trade_chan AS reg21_251_0_,
       this_.stimestamp AS stimestamp251_0_, this_.ud_dt AS ud23_251_0_,
       this_.reg_dis_code AS reg24_251_0_,
       this_.updated_stimestamp AS updated25_251_0_,
       this_.vip_flag AS vip26_251_0_
  FROM ac_cust this_
 WHERE this_.cust_stat = :1 AND this_.id_no IN (:2)
 
 


