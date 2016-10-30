select * from CM_WEB_TRADE_ACCT_CMESSAGE t

Create index id_type_index on CM_WEB_TRADE_ACCT_CMESSAGE (id_type);
Create index id_no_index on CM_WEB_TRADE_ACCT_CMESSAGE (id_no);

Create unique index rule_id on CM_ACCT_RULES (rule_id);
