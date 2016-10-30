create table CM_ACCT_RULES
(
  rule_id             VARCHAR2(30) not null,
  rule_name           VARCHAR2(30),
  all_scores          NUMBER(18,2),
  all_count_scores    NUMBER(18,2),
  all_count_num       NUMBER(18),
  all_m_count_scores  NUMBER(18,2),
  all_m_count_num     NUMBER(18),
  all_dt_count_scores NUMBER(18,2),
  all_dt_count_num    NUMBER(18),
  cre_pes             VARCHAR2(30),
  countscores         NUMBER(18,2) default 0.00,
  sendtime            VARCHAR2(8)
)
tablespace CUSTDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64
    minextents 1
    maxextents unlimited
  );
  
  
  create table CM_WEB_USER_ACCT
(
  id_type     VARCHAR2(2) not null,
  id_no       VARCHAR2(20) not null,
  acct_scores NUMBER(18,2)
)
tablespace CUSTDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16
    minextents 1
    maxextents unlimited
  );
  
  create index ID_NO on CM_WEB_USER_ACCT (ID_NO)
  tablespace CUSTDATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
  create table CM_WEB_USER_ACCT_ACCESS
(
  acct_no     VARCHAR2(20) not null,
  serial_no   VARCHAR2(32),
  cre_dt      TIMESTAMP(6),
  user_acct   VARCHAR2(30),
  rule_id     VARCHAR2(8),
  score       NUMBER(18,2),
  access_type VARCHAR2(1),
  serial_id   NVARCHAR2(32),
  task_id     NUMBER(18),
  state_type  NVARCHAR2(2),
  tradevol    NUMBER(18,2),
  bankno      NVARCHAR2(32),
  bankname    NVARCHAR2(32),
  product_id  NUMBER,
  ver         VARCHAR2(100),
  sub_model   VARCHAR2(100),
  par_model   VARCHAR2(100),
  channel_id  NVARCHAR2(30),
  reg_source  VARCHAR2(1),
  id_type     VARCHAR2(1)
)
tablespace CUSTDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16
    minextents 1
    maxextents unlimited
  );
  
  create index ACCT_NO on CM_WEB_USER_ACCT_ACCESS (ACCT_NO, RULE_ID, TASK_ID)
  tablespace CUSTDATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
  
  create table CM_WEB_TRADE_ACCT_CMESSAGE
(
  id_type       VARCHAR2(2) not null,
  id_no         VARCHAR2(20) not null,
  all_scores    NUMBER(18,2),
  all_num       NUMBER(18),
  all_m_scores  NUMBER(18,2),
  all_m_num     NUMBER(18),
  all_dt_scores NUMBER(18,2),
  all_dt_num    NUMBER(18),
  rule_id       VARCHAR2(8),
  last_dt       NVARCHAR2(30)
)
tablespace CUSTDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16
    minextents 1
    maxextents unlimited
  );
  
  create table CM_WEB_USER_ACCT
(
  id_type     VARCHAR2(2) not null,
  id_no       VARCHAR2(20) not null,
  acct_scores NUMBER(18,2)
)
tablespace CUSTDATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16
    minextents 1
    maxextents unlimited
  );
