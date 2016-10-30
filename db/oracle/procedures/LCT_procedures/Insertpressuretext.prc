/*exec INSERTPRESSURETEXT('20151126');*/
/*
Declare
Begin
  Insertpressuretext('20151126');
End;
*/
Create Or Replace Procedure Insertpressuretext(DT IN VARCHAR2) Is
  /*理财通基金销售维护表*/
  Cursor Cur Is
    Select * From Bp_Lct_Fund_Cfg;
  /*结算人代码*/
  PartCode Varchar2(30);
  /*TA代码*/
  TaCode Varchar2(2);
  /*游标*/
  v_Row Cur%Rowtype;
  v_count Int;
  /*计数器*/
  i Int := 1;
  z Int := 1;
  /*基金代码下标*/
  v_fundCodeIndex Int := 1;
  /*TA代码下标*/
  v_taCodeIndex Int := 1;
  /*基金代码数组*/
  TYPE t_fundCode IS TABLE OF VARCHAR2(30) INDEX BY BINARY_INTEGER;
  v_fundCode t_fundCode;
  /*TA代码数组*/
  TYPE t_taCode IS TABLE OF VARCHAR2(30) INDEX BY BINARY_INTEGER;
  v_taCode t_taCode;
  
  
  

Begin
  --循环交易清算日期配置表
  For v_Row In Cur Loop
    --判断如果基金存在则继续处理,不存在则跳出本次循环
    Select count(*) into v_count From Bp_Fund_Basic_Info Where Fund_Code = v_Row.Fund_Code;
    if v_count=0
      Then
        goto conutnu;
      Else
        --清除数据,交易清算日期配置表
        Delete From Cp_Settle_Dt_Cfg Where Fund_Code = v_Row.fund_code And Busi_Type = '08';
        --查询基金基本信息
        Select Part_Code,TA_CODE Into Partcode,TaCode From Bp_Fund_Basic_Info Where Fund_Code = v_Row.Fund_Code;
        --加入数组
        v_fundCode(v_fundCodeIndex) := v_Row.fund_code;
        v_taCode(v_taCodeIndex) := TaCode;
        v_fundCodeIndex := v_fundCodeIndex+1;
        v_taCodeIndex := v_taCodeIndex+1;
        --打印
        --Dbms_Output.Put_Line('基金代码' || v_Row.fund_code);
        
        /*插入交易清算日期配置表*/
        /*Busi_Code 124-赎回确认, Ack_Rslt 确认结果:1-成功 */
        Insert Into Cp_Settle_Dt_Cfg
          (Settle_Dt_Cfg_Id,Ta_Code,Fund_Code,Share_Class,Busi_Code,Ack_Rslt,Busi_Type,Settle_Days,Settle_Dt,
           Memo,Rec_Stat,Creator,Modifier,Checker,Check_Flag,Cre_Dt,Mod_Dt,Settle_Dt_Type,Settle_Dt_Freq,
           Fund_Man_Code,Part_Code)
           Values
          (To_Char(Sysdate, 'YYYYMMDDHH24MISS') || i,TaCode,v_Row.fund_code,Null,'124','1','08','2',Null,
           Null,'0',DT,Null,'','1',DT,DT,'1',Null,'***',Partcode);
        i := i + 1;
        
        /*Busi_Code 124-赎回确认, Ack_Rslt 确认结果:0-失败 */
        Insert Into Cp_Settle_Dt_Cfg
          (Settle_Dt_Cfg_Id,Ta_Code,Fund_Code,Share_Class,Busi_Code,Ack_Rslt,Busi_Type,Settle_Days,Settle_Dt,
           Memo,Rec_Stat,Creator,Modifier,Checker,Check_Flag,Cre_Dt,Mod_Dt,Settle_Dt_Type,Settle_Dt_Freq,
           Fund_Man_Code,Part_Code)
           Values
          (To_Char(Sysdate, 'YYYYMMDDHH24MISS') || i,TaCode,v_Row.fund_code,Null,'124','0','08','2',Null,
           Null,'0',DT,Null,'','1',DT,DT,'1',Null,'***',Partcode);
        i := i + 1;
        
        /*Busi_Code 122-申购确认, Ack_Rslt 确认结果:1-成功 */
        Insert Into Cp_Settle_Dt_Cfg
          (Settle_Dt_Cfg_Id,Ta_Code,Fund_Code,Share_Class,Busi_Code,Ack_Rslt,Busi_Type,Settle_Days,Settle_Dt,
           Memo,Rec_Stat,Creator,Modifier,Checker,Check_Flag,Cre_Dt,Mod_Dt,Settle_Dt_Type,Settle_Dt_Freq,
           Fund_Man_Code,Part_Code)
           Values
          (To_Char(Sysdate, 'YYYYMMDDHH24MISS') || i,TaCode,v_Row.fund_code,Null,'122','1','08','2',Null,
           Null,'0',DT,Null,'','1',DT,DT,'1',Null,'***',Partcode);
        i := i + 1;
        
        /*Busi_Code 122-申购确认, Ack_Rslt 确认结果:0-失败 */
        Insert Into Cp_Settle_Dt_Cfg
          (Settle_Dt_Cfg_Id,Ta_Code,Fund_Code,Share_Class,Busi_Code,Ack_Rslt,Busi_Type,Settle_Days,Settle_Dt,
           Memo,Rec_Stat,Creator,Modifier,Checker,Check_Flag,Cre_Dt,Mod_Dt,Settle_Dt_Type,Settle_Dt_Freq,
           Fund_Man_Code,Part_Code)
           Values
          (To_Char(Sysdate, 'YYYYMMDDHH24MISS') || i,TaCode,v_Row.fund_code,Null,'122','0','08','2',Null,
           Null,'0',DT,Null,'','1',DT,DT,'1',Null,'***',Partcode);
        i := i + 1;
        
        /*Busi_Code 142-强赎, Ack_Rslt 确认结果:1-成功 */
        Insert Into Cp_Settle_Dt_Cfg
          (Settle_Dt_Cfg_Id,Ta_Code,Fund_Code,Share_Class,Busi_Code,Ack_Rslt,Busi_Type,Settle_Days,Settle_Dt,
           Memo,Rec_Stat,Creator,Modifier,Checker,Check_Flag,Cre_Dt,Mod_Dt,Settle_Dt_Type,Settle_Dt_Freq,
           Fund_Man_Code,Part_Code)
           Values
          (To_Char(Sysdate, 'YYYYMMDDHH24MISS') || i,TaCode,v_Row.fund_code,Null,'142','1','08','2',Null,
           Null,'0',DT,Null,'','1',DT,DT,'1',Null,'***',Partcode);
        i := i + 1;
        
        /*Busi_Code 142-强赎, Ack_Rslt 确认结果:0-失败 */
        Insert Into Cp_Settle_Dt_Cfg
          (Settle_Dt_Cfg_Id,Ta_Code,Fund_Code,Share_Class,Busi_Code,Ack_Rslt,Busi_Type,Settle_Days,Settle_Dt,
           Memo,Rec_Stat,Creator,Modifier,Checker,Check_Flag,Cre_Dt,Mod_Dt,Settle_Dt_Type,Settle_Dt_Freq,
           Fund_Man_Code,Part_Code)
           Values
          (To_Char(Sysdate, 'YYYYMMDDHH24MISS') || i,TaCode,v_Row.fund_code,Null,'142','0','08','2',Null,
           Null,'0',DT,Null,'','1',DT,DT,'1',Null,'***',Partcode);
        i := i + 1;
        
        /*Busi_Code 143-分红, Ack_Rslt 确认结果:1-成功 */
        Insert Into Cp_Settle_Dt_Cfg
          (Settle_Dt_Cfg_Id,Ta_Code,Fund_Code,Share_Class,Busi_Code,Ack_Rslt,Busi_Type,Settle_Days,Settle_Dt,
           Memo,Rec_Stat,Creator,Modifier,Checker,Check_Flag,Cre_Dt,Mod_Dt,Settle_Dt_Type,Settle_Dt_Freq,
           Fund_Man_Code,Part_Code)
           Values
          (To_Char(Sysdate, 'YYYYMMDDHH24MISS') || i,TaCode,v_Row.fund_code,Null,'143','1','08','2',Null,
           Null,'0',DT,Null,'','1',DT,DT,'1',Null,'***',Partcode);
        i := i + 1;
        
        /*Busi_Code 143-分红, Ack_Rslt 确认结果:0-失败 */
        Insert Into Cp_Settle_Dt_Cfg
          (Settle_Dt_Cfg_Id,Ta_Code,Fund_Code,Share_Class,Busi_Code,Ack_Rslt,Busi_Type,Settle_Days,Settle_Dt,
           Memo,Rec_Stat,Creator,Modifier,Checker,Check_Flag,Cre_Dt,Mod_Dt,Settle_Dt_Type,Settle_Dt_Freq,
           Fund_Man_Code,Part_Code)
           Values
          (To_Char(Sysdate, 'YYYYMMDDHH24MISS') || i,TaCode,v_Row.fund_code,Null,'143','0','08','2',Null,
           Null,'0',DT,Null,'','1',DT,DT,'1',Null,'***',Partcode);
        i := i + 1;
        
        
    End If;
    
    <<conutnu>>
    Dbms_Output.Put_Line('每次循环结束,当前基金代码:'||v_Row.fund_code);
  End Loop;
  Dbms_Output.Put_Line('循环结束,基金代码与TA代码数组长度' || v_fundCode.COUNT || ',' || v_taCode.COUNT);
  
  Commit;
  
  i := 0;
  Dbms_Output.Put_Line('基金代码与TA代码数组长度' || v_fundCode.COUNT || ',' || v_taCode.COUNT);
  /*根据日期删除确认清算数据*/
  Delete From St_Trade_Ack_Settle Where Trade_Dt = Dt;
  Dbms_Output.Put_Line('插入确认数据,非理财通申购失败 122');
  
  /*新增 非理财通申购失败 Busi_Code=122*/
  While i < 10000 Loop
    Insert Into St_Trade_Ack_Settle
    (/*1~10*/
     App_Serial_No,Ack_Serial_No,Ta_Serial_No,Trade_Dt,From_Ta_Flag,Cust_No,Busi_Code,Fund_Acct_No,Fund_Tx_Acct_No,Currency,
     /*11~20*/
     App_Dt,App_Amt,App_Vol,Ack_Amt,Ack_Vol,Ta_Code,Fund_Code,Share_Class,Service_Fee,From_Busi_Code, /*垫资户默认189*/
     /*21~30*/
     Ack_Dt,Ret_Code,Transfer_Fee,Min_Fee,Large_Redm_Flag,Punish_Fee,Breach_Fee_Back_To_Fund,Breach_Fee,Undistri_Monetary_Inc_Flag,Undistri_Monetary_Inc,
     /*31~40*/
     Achiev_Compen,Achiev_Pay,Sale_Percent,Refund_Amt,Backenload_Disc,Other_Fee2,Target_Trade_Price,Target_Nav,Tax,Dividend_Ratio,
     /*41~50*/
     Raise_Interest,Recu_Agency_Fee,Change_Agency_Fee,Recu_Fee,Change_Fee,Man_Real_Ratio,Total_Trans_Fee,Trade_Price,Vol_By_Interest,Fee_Rate,
     /*51~60*/
     Valid_Period,Other_Fee1,Tack_Vol,Trade_Chan,Agency_Fee,Balance,Back_Fee,Detail_Flag,Redm_Stat,Nav,
     /*61~70*/
     Disc_Rate_Of_Comm,Interest_Tax,Interest,Stamp_Duty,Fee,Outlet_Code,Region_Code,Seat_No,App_Tm,Invst_Type,
     Rec_Stat)
  Values
    (/*1~10*/
     'flctssss'||i, Seq_Ackserialno.Nextval,Seq_Contractno.Nextval,Dt,'0','fssss'||i,'122','481A00201315',Lpad(Seq_Fundtxacctno.Nextval, '13', '304100'),'156',
     /*11~20*/
     Dt,10000,1.00,10000,1.00,v_taCode(1),v_fundCode(1),'A',0,'',
     /*21~30*/
     Dt,'000',0.00,0.00000,'0',0.00,0.00,0.00,'0',0.00,
     /*31~40*/
     0.00,0.00,0.00000,0.00,0.00000,0.00,0.0000,0.0000,0.00,0.00,
     /*41~50*/
     0.00,0.00,0.00,0.00,0.00,1.0000,0.00,1.000000,0.00,0.00000,
     /*51~60*/
     0,0.00,0.00000,'2',0.00000,0.00000,0.00000,'0','9',1.000000,
     /*61~70*/
     1.0000,0.00000,0.00000,0.00000,0.00000,'WEB000001','web','304','090000','1',
     '0');
  
  i := i + 1;
  End Loop;

  Commit;
  
  i := 0;
  Dbms_Output.Put_Line('插入确认数据,非理财通赎回成功 124');
  
  /*新增 非理财通赎回成功 Busi_Code=124*/
  While i < 30000 Loop
    Insert Into St_Trade_Ack_Settle
    (/*1~10*/
     App_Serial_No,Ack_Serial_No,Ta_Serial_No,Trade_Dt,From_Ta_Flag,Cust_No,Busi_Code,Fund_Acct_No,Fund_Tx_Acct_No,Currency,
     /*11~20*/
     App_Dt,App_Amt,App_Vol,Ack_Amt,Ack_Vol,Ta_Code,Fund_Code,Share_Class,Service_Fee,From_Busi_Code, /*垫资户默认189*/
     /*21~30*/
     Ack_Dt,Ret_Code,Transfer_Fee,Min_Fee,Large_Redm_Flag,Punish_Fee,Breach_Fee_Back_To_Fund,Breach_Fee,Undistri_Monetary_Inc_Flag,Undistri_Monetary_Inc,
     /*31~40*/
     Achiev_Compen,Achiev_Pay,Sale_Percent,Refund_Amt,Backenload_Disc,Other_Fee2,Target_Trade_Price,Target_Nav,Tax,Dividend_Ratio,
     /*41~50*/
     Raise_Interest,Recu_Agency_Fee,Change_Agency_Fee,Recu_Fee,Change_Fee,Man_Real_Ratio,Total_Trans_Fee,Trade_Price,Vol_By_Interest,Fee_Rate,
     /*51~60*/
     Valid_Period,Other_Fee1,Tack_Vol,Trade_Chan,Agency_Fee,Balance,Back_Fee,Detail_Flag,Redm_Stat,Nav,
     /*61~70*/
     Disc_Rate_Of_Comm,Interest_Tax,Interest,Stamp_Duty,Fee,Outlet_Code,Region_Code,Seat_No,App_Tm,Invst_Type,
     Rec_Stat)
  Values
    (/*1~10*/
     'flctshcg'||i, Seq_Ackserialno.Nextval,Seq_Contractno.Nextval,Dt,'0','fshcg'||i,'124','481A00201315',Lpad(Seq_Fundtxacctno.Nextval, '13', '304100'),'156',
     /*11~20*/
     Dt,10000,1.00,10000,1.00,v_taCode(2),v_fundCode(2),'A',0,'',
     /*21~30*/
     Dt,'0000',0.00,0.00000,'0',0.00,0.00,0.00,'0',0.00,
     /*31~40*/
     0.00,0.00,0.00000,0.00,0.00000,0.00,0.0000,0.0000,0.00,0.00,
     /*41~50*/
     0.00,0.00,0.00,0.00,0.00,1.0000,0.00,1.000000,0.00,0.00000,
     /*51~60*/
     0,0.00,0.00000,'2',0.00000,0.00000,0.00000,'0','9',1.000000,
     /*61~70*/
     1.0000,0.00000,0.00000,0.00000,0.00000,'WEB000001','web','304','090000','1',
     '0');
  
  i := i + 1;
  End Loop;

  Commit;
  
  i := 0;
  z := 1;
  v_count := v_fundCode.count;/*总基金代码数量*/
  Dbms_Output.Put_Line('插入确认数据,非理财通分红 143');
  
  /*新增 非理财通分红 Busi_Code=143*/
  While i < 10000 Loop
    /*判断拼接FUND_TX_ACCT_NO 基金交易账号 */
    If z > v_count Then
      z := 1;
    End If;
    
    Insert Into St_Trade_Ack_Settle
    (/*1~10*/
     App_Serial_No,Ack_Serial_No,Ta_Serial_No,Trade_Dt,From_Ta_Flag,Cust_No,Busi_Code,Fund_Acct_No,Fund_Tx_Acct_No,Currency,
     /*11~20*/
     App_Dt,App_Amt,App_Vol,Ack_Amt,Ack_Vol,Ta_Code,Fund_Code,Share_Class,Service_Fee,From_Busi_Code, /*垫资户默认189*/
     /*21~30*/
     Ack_Dt,Ret_Code,Transfer_Fee,Min_Fee,Large_Redm_Flag,Punish_Fee,Breach_Fee_Back_To_Fund,Breach_Fee,Undistri_Monetary_Inc_Flag,Undistri_Monetary_Inc,
     /*31~40*/
     Achiev_Compen,Achiev_Pay,Sale_Percent,Refund_Amt,Backenload_Disc,Other_Fee2,Target_Trade_Price,Target_Nav,Tax,Dividend_Ratio,
     /*41~50*/
     Raise_Interest,Recu_Agency_Fee,Change_Agency_Fee,Recu_Fee,Change_Fee,Man_Real_Ratio,Total_Trans_Fee,Trade_Price,Vol_By_Interest,Fee_Rate,
     /*51~60*/
     Valid_Period,Other_Fee1,Tack_Vol,Trade_Chan,Agency_Fee,Balance,Back_Fee,Detail_Flag,Redm_Stat,Nav,
     /*61~70*/
     Disc_Rate_Of_Comm,Interest_Tax,Interest,Stamp_Duty,Fee,Outlet_Code,Region_Code,Seat_No,App_Tm,Invst_Type,
     Rec_Stat,Div_Mode,Reg_Dt)
  Values
    (/*1~10*/
     'flctfh'||i, Seq_Ackserialno.Nextval,Seq_Contractno.Nextval,Dt,'0','ffh'||i,'143','481A00201315','flct' || Lpad(z, 4, '0'),'156',
     /*11~20*/
     Dt,10000,1.00,10000,1.00,v_taCode(3),v_fundCode(3),'A',0,'',
     /*21~30*/
     Dt,'0000',0.00,0.00000,'0',0.00,0.00,0.00,'0',0.00,
     /*31~40*/
     0.00,0.00,0.00000,0.00,0.00000,0.00,0.0000,0.0000,0.00,0.00,
     /*41~50*/
     0.00,0.00,0.00,0.00,0.00,1.0000,0.00,1.000000,0.00,0.00000,
     /*51~60*/
     0,0.00,0.00000,'2',0.00000,0.00000,0.00000,'0','9',1.000000,
     /*61~70*/
     1.0000,0.00000,0.00000,0.00000,0.00000,'WEB000001','web','304','090000','1',
     '0','1',Dt);
  
  i := i + 1;
  z := z + 1;
  End Loop;

  Commit;
  
  i := 0;
  Dbms_Output.Put_Line('理财通申购 122');
  
  /*新增 理财通申购 Busi_Code=122*/
  While i < 30000 Loop
    Insert Into St_Trade_Ack_Settle
    (/*1~10*/
     App_Serial_No,Ack_Serial_No,Ta_Serial_No,Trade_Dt,From_Ta_Flag,Cust_No,Busi_Code,Fund_Acct_No,Fund_Tx_Acct_No,Currency,
     /*11~20*/
     App_Dt,App_Amt,App_Vol,Ack_Amt,Ack_Vol,Ta_Code,Fund_Code,Share_Class,Service_Fee,From_Busi_Code, /*垫资户默认189*/
     /*21~30*/
     Ack_Dt,Ret_Code,Transfer_Fee,Min_Fee,Large_Redm_Flag,Punish_Fee,Breach_Fee_Back_To_Fund,Breach_Fee,Undistri_Monetary_Inc_Flag,Undistri_Monetary_Inc,
     /*31~40*/
     Achiev_Compen,Achiev_Pay,Sale_Percent,Refund_Amt,Backenload_Disc,Other_Fee2,Target_Trade_Price,Target_Nav,Tax,Dividend_Ratio,
     /*41~50*/
     Raise_Interest,Recu_Agency_Fee,Change_Agency_Fee,Recu_Fee,Change_Fee,Man_Real_Ratio,Total_Trans_Fee,Trade_Price,Vol_By_Interest,Fee_Rate,
     /*51~60*/
     Valid_Period,Other_Fee1,Tack_Vol,Trade_Chan,Agency_Fee,Balance,Back_Fee,Detail_Flag,Redm_Stat,Nav,
     /*61~70*/
     Disc_Rate_Of_Comm,Interest_Tax,Interest,Stamp_Duty,Fee,Outlet_Code,Region_Code,Seat_No,App_Tm,Invst_Type,
     Rec_Stat)
  Values
    (/*1~10*/
     'lctsscg'||i, Seq_Ackserialno.Nextval,Seq_Contractno.Nextval,Dt,'0','lsscg'||i,'122','481A00201315',Lpad(Seq_Fundtxacctno.Nextval, '13', '304100'),'156',
     /*11~20*/
     Dt,10000,1.00,10000,1.00,v_taCode(4),v_fundCode(4),'A',0,'',
     /*21~30*/
     Dt,'0000',0.00,0.00000,'0',0.00,0.00,0.00,'0',0.00,
     /*31~40*/
     0.00,0.00,0.00000,0.00,0.00000,0.00,0.0000,0.0000,0.00,0.00,
     /*41~50*/
     0.00,0.00,0.00,0.00,0.00,1.0000,0.00,1.000000,0.00,0.00000,
     /*51~60*/
     0,0.00,0.00000,'2',0.00000,0.00000,0.00000,'0','9',1.000000,
     /*61~70*/
     1.0000,0.00000,0.00000,0.00000,0.00000,'WEB000001','web','304','090000','1',
     '0');
  
  i := i + 1;
  End Loop;

  Commit;
  
  i := 0;
  Dbms_Output.Put_Line('理财通赎回 124');
  
  /*新增 理财通赎回 Busi_Code=124*/
  While i < 30000 Loop
    Insert Into St_Trade_Ack_Settle
    (/*1~10*/
     App_Serial_No,Ack_Serial_No,Ta_Serial_No,Trade_Dt,From_Ta_Flag,Cust_No,Busi_Code,Fund_Acct_No,Fund_Tx_Acct_No,Currency,
     /*11~20*/
     App_Dt,App_Amt,App_Vol,Ack_Amt,Ack_Vol,Ta_Code,Fund_Code,Share_Class,Service_Fee,From_Busi_Code, /*垫资户默认189*/
     /*21~30*/
     Ack_Dt,Ret_Code,Transfer_Fee,Min_Fee,Large_Redm_Flag,Punish_Fee,Breach_Fee_Back_To_Fund,Breach_Fee,Undistri_Monetary_Inc_Flag,Undistri_Monetary_Inc,
     /*31~40*/
     Achiev_Compen,Achiev_Pay,Sale_Percent,Refund_Amt,Backenload_Disc,Other_Fee2,Target_Trade_Price,Target_Nav,Tax,Dividend_Ratio,
     /*41~50*/
     Raise_Interest,Recu_Agency_Fee,Change_Agency_Fee,Recu_Fee,Change_Fee,Man_Real_Ratio,Total_Trans_Fee,Trade_Price,Vol_By_Interest,Fee_Rate,
     /*51~60*/
     Valid_Period,Other_Fee1,Tack_Vol,Trade_Chan,Agency_Fee,Balance,Back_Fee,Detail_Flag,Redm_Stat,Nav,
     /*61~70*/
     Disc_Rate_Of_Comm,Interest_Tax,Interest,Stamp_Duty,Fee,Outlet_Code,Region_Code,Seat_No,App_Tm,Invst_Type,
     Rec_Stat)
  Values
    (/*1~10*/
     'lctshcg'||i, Seq_Ackserialno.Nextval,Seq_Contractno.Nextval,Dt,'0','lshcg'||i,'124','481A00201315',Lpad(Seq_Fundtxacctno.Nextval, '13', '304100'),'156',
     /*11~20*/
     Dt,10000,1.00,10000,1.00,v_taCode(5),v_fundCode(5),'A',0,'',
     /*21~30*/
     Dt,'0000',0.00,0.00000,'0',0.00,0.00,0.00,'0',0.00,
     /*31~40*/
     0.00,0.00,0.00000,0.00,0.00000,0.00,0.0000,0.0000,0.00,0.00,
     /*41~50*/
     0.00,0.00,0.00,0.00,0.00,1.0000,0.00,1.000000,0.00,0.00000,
     /*51~60*/
     0,0.00,0.00000,'2',0.00000,0.00000,0.00000,'0','9',1.000000,
     /*61~70*/
     1.0000,0.00000,0.00000,0.00000,0.00000,'WEB000001','web','304','090000','1',
     '0');
  
  i := i + 1;
  End Loop;

  Commit;
  
  i := 0;
  z := 1;
  v_count := v_fundCode.count;/*总基金代码数量*/
  Dbms_Output.Put_Line('理财通分红 143');
  
  /*新增 理财通分红 Busi_Code=143*/
  While i < 5000 Loop
    /*判断拼接FUND_TX_ACCT_NO 基金交易账号 */
    If z > v_count Then
      z := 1;
    End If;
    
    Insert Into St_Trade_Ack_Settle
    (/*1~10*/
     App_Serial_No,Ack_Serial_No,Ta_Serial_No,Trade_Dt,From_Ta_Flag,Cust_No,Busi_Code,Fund_Acct_No,Fund_Tx_Acct_No,Currency,
     /*11~20*/
     App_Dt,App_Amt,App_Vol,Ack_Amt,Ack_Vol,Ta_Code,Fund_Code,Share_Class,Service_Fee,From_Busi_Code, /*垫资户默认189*/
     /*21~30*/
     Ack_Dt,Ret_Code,Transfer_Fee,Min_Fee,Large_Redm_Flag,Punish_Fee,Breach_Fee_Back_To_Fund,Breach_Fee,Undistri_Monetary_Inc_Flag,Undistri_Monetary_Inc,
     /*31~40*/
     Achiev_Compen,Achiev_Pay,Sale_Percent,Refund_Amt,Backenload_Disc,Other_Fee2,Target_Trade_Price,Target_Nav,Tax,Dividend_Ratio,
     /*41~50*/
     Raise_Interest,Recu_Agency_Fee,Change_Agency_Fee,Recu_Fee,Change_Fee,Man_Real_Ratio,Total_Trans_Fee,Trade_Price,Vol_By_Interest,Fee_Rate,
     /*51~60*/
     Valid_Period,Other_Fee1,Tack_Vol,Trade_Chan,Agency_Fee,Balance,Back_Fee,Detail_Flag,Redm_Stat,Nav,
     /*61~70*/
     Disc_Rate_Of_Comm,Interest_Tax,Interest,Stamp_Duty,Fee,Outlet_Code,Region_Code,Seat_No,App_Tm,Invst_Type,
     Rec_Stat,Div_Mode,Reg_Dt)
  Values
    (/*1~10*/
     'lctfh'||i, Seq_Ackserialno.Nextval,Seq_Contractno.Nextval,Dt,'0','lfh'||i,'143','481A00201315','lct' || Lpad(z, 4, '0'),'156',
     /*11~20*/
     Dt,10000,1.00,10000,1.00,v_taCode(6),v_fundCode(6),'A',0,'',
     /*21~30*/
     Dt,'0000',0.00,0.00000,'0',0.00,0.00,0.00,'0',0.00,
     /*31~40*/
     0.00,0.00,0.00000,0.00,0.00000,0.00,0.0000,0.0000,0.00,0.00,
     /*41~50*/
     0.00,0.00,0.00,0.00,0.00,1.0000,0.00,1.000000,0.00,0.00000,
     /*51~60*/
     0,0.00,0.00000,'2',0.00000,0.00000,0.00000,'0','9',1.000000,
     /*61~70*/
     1.0000,0.00000,0.00000,0.00000,0.00000,'WEB000001','web','304','090000','1',
     '0','1',Dt);
  
  i := i + 1;
  z := z + 1;
  End Loop;

  Commit;
  
  i := 0;
  z := 1;
  v_count := v_fundCode.count;/*总基金代码数量*/
  Dbms_Output.Put_Line('理财通强赎 142');
  
  /*新增 理财通强赎 Busi_Code=142*/
  While i < 5000 Loop
    /*判断拼接FUND_TX_ACCT_NO 基金交易账号 */
    If z > v_count Then
      z := 1;
    End If;
    
    Insert Into St_Trade_Ack_Settle
    (/*1~10*/
     App_Serial_No,Ack_Serial_No,Ta_Serial_No,Trade_Dt,From_Ta_Flag,Cust_No,Busi_Code,Fund_Acct_No,Fund_Tx_Acct_No,Currency,
     /*11~20*/
     App_Dt,App_Amt,App_Vol,Ack_Amt,Ack_Vol,Ta_Code,Fund_Code,Share_Class,Service_Fee,From_Busi_Code, /*垫资户默认189*/
     /*21~30*/
     Ack_Dt,Ret_Code,Transfer_Fee,Min_Fee,Large_Redm_Flag,Punish_Fee,Breach_Fee_Back_To_Fund,Breach_Fee,Undistri_Monetary_Inc_Flag,Undistri_Monetary_Inc,
     /*31~40*/
     Achiev_Compen,Achiev_Pay,Sale_Percent,Refund_Amt,Backenload_Disc,Other_Fee2,Target_Trade_Price,Target_Nav,Tax,Dividend_Ratio,
     /*41~50*/
     Raise_Interest,Recu_Agency_Fee,Change_Agency_Fee,Recu_Fee,Change_Fee,Man_Real_Ratio,Total_Trans_Fee,Trade_Price,Vol_By_Interest,Fee_Rate,
     /*51~60*/
     Valid_Period,Other_Fee1,Tack_Vol,Trade_Chan,Agency_Fee,Balance,Back_Fee,Detail_Flag,Redm_Stat,Nav,
     /*61~70*/
     Disc_Rate_Of_Comm,Interest_Tax,Interest,Stamp_Duty,Fee,Outlet_Code,Region_Code,Seat_No,App_Tm,Invst_Type,
     Rec_Stat)
  Values
    (/*1~10*/
     'lctqs'||i, Seq_Ackserialno.Nextval,Seq_Contractno.Nextval,Dt,'0','lqs'||i,'142','481A00201315','lct' || Lpad(z, 4, '0'),'156',
     /*11~20*/
     Dt,10000,1.00,10000,1.00,v_taCode(7),v_fundCode(7),'A',0,'',
     /*21~30*/
     Dt,'0000',0.00,0.00000,'0',0.00,0.00,0.00,'0',0.00,
     /*31~40*/
     0.00,0.00,0.00000,0.00,0.00000,0.00,0.0000,0.0000,0.00,0.00,
     /*41~50*/
     0.00,0.00,0.00,0.00,0.00,1.0000,0.00,1.000000,0.00,0.00000,
     /*51~60*/
     0,0.00,0.00000,'2',0.00000,0.00000,0.00000,'0','9',1.000000,
     /*61~70*/
     1.0000,0.00000,0.00000,0.00000,0.00000,'WEB000001','web','304','090000','1',
     '0');
  
  i := i + 1;
  z := z + 1;
  End Loop;

  Commit;
  
  /*处理基金余额表 非理财通 分红*/
  i := 0;
  z := 1;
  v_count := v_fundCode.count;/*总基金代码数量*/
  Dbms_Output.Put_Line('处理基金余额表 非理财通 分红');
  
  /*删除*/
  Delete From Ac_Dis_Fund_Acct_Bal b ;
  
  While i < 10000 Loop
    /*判断拼接FUND_TX_ACCT_NO 基金交易账号 */
    If z > v_count Then
      z := 1;
    End If;
    
    /*新增 非理财通 分红 */
    Insert Into Ac_Dis_Fund_Acct_Bal 
    (/*1~10*/
    Dis_Fund_Tx_Acct_No,Dis_Code,Protocal_No,Fund_Tx_Acct_No,Fund_Code,Fund_Acct_No,Balance_Vol,Share_Class,Avail_Vol,Frzn_Vol,
    /*11~*/
    Just_Frzn_Vol,Ta_Code,Reg_Dt,Ud_Dt,Last_Subs_Dt,Cre_Dt,Mod_Dt,Stimestamp,Cust_Bank_Id)
    Values (
    /*1~10*/
    DT || i,'HB000A001'/*好买*/, 'flctxyh','flct' || Lpad(z, 4, '0'),v_fundCode(3),v_fundCode(3) || i,'10000','A','10000','0',
    /*11~*/
    '0',v_taCode(3),DT,DT,DT,Dt,DT,Sysdate,v_fundCode(3)
    );
    
  i := i + 1;
  z := z + 1;
  End Loop;

  Commit;
  
  /*处理基金余额表 理财通 分红*/
  i := 0;
  z := 1;
  v_count := v_fundCode.count;/*总基金代码数量*/
  Dbms_Output.Put_Line('处理基金余额表 理财通 分红');
  
  While i < 5000 Loop
    /*判断拼接FUND_TX_ACCT_NO 基金交易账号 */
    If z > v_count Then
      z := 1;
    End If;
    
    /*理财通 分红*/
    Insert Into Ac_Dis_Fund_Acct_Bal 
    (/*1~10*/
    Dis_Fund_Tx_Acct_No,Dis_Code,Protocal_No,Fund_Tx_Acct_No,Fund_Code,Fund_Acct_No,Balance_Vol,Share_Class,Avail_Vol,Frzn_Vol,
    /*11~*/
    Just_Frzn_Vol,Ta_Code,Reg_Dt,Ud_Dt,Last_Subs_Dt,Cre_Dt,Mod_Dt,Stimestamp,Cust_Bank_Id)
    Values (
    /*1~10*/
    DT || i,'LCT00K001'/*理财通*/, 'lctxyh','lct' || Lpad(z, 4, '0'),v_fundCode(6),v_fundCode(6) || i,'10000','A','10000','0',
    /*11~*/
    '0',v_taCode(6),DT,DT,DT,Dt,DT,Sysdate,v_fundCode(6)
    );
    
  i := i + 1;
  z := z + 1;
  End Loop;

  Commit;
  
  /*处理基金余额表 理财通 强赎*/
  i := 0;
  z := 1;
  v_count := v_fundCode.count;/*总基金代码数量*/
  Dbms_Output.Put_Line('处理基金余额表 理财通 强赎');
  
  While i < 5000 Loop
    /*判断拼接FUND_TX_ACCT_NO 基金交易账号 */
    If z > v_count Then
      z := 1;
    End If;
    
    /*理财通 强赎*/
    Insert Into Ac_Dis_Fund_Acct_Bal 
    (/*1~10*/
    Dis_Fund_Tx_Acct_No,Dis_Code,Protocal_No,Fund_Tx_Acct_No,Fund_Code,Fund_Acct_No,Balance_Vol,Share_Class,Avail_Vol,Frzn_Vol,
    /*11~*/
    Just_Frzn_Vol,Ta_Code,Reg_Dt,Ud_Dt,Last_Subs_Dt,Cre_Dt,Mod_Dt,Stimestamp,Cust_Bank_Id)
    Values (
    /*1~10*/
    DT || i,'LCT00K001'/*理财通*/, 'lctxyh','lct' || Lpad(z, 4, '0'),v_fundCode(7),v_fundCode(7) || i,'10000','A','10000','0',
    /*11~*/
    '0',v_taCode(7),DT,DT,DT,Dt,DT,Sysdate,v_fundCode(7)
    );
    
  i := i + 1;
  z := z + 1;
  End Loop;

  Commit;
  
  /*处理客户银行账户信息Cust_Bank_Id关联*/
  i := 0;
  Dbms_Output.Put_Line('处理客户银行账户信息表');
  v_count := v_fundCode.count;/*总基金代码数量*/
  
  For i In 1 .. v_count Loop 
    /*客户银行账户信息Cust_Bank_Id关联*/
    /*删除*/
    Delete From Cp_Cust_Bank_Acct_Info b Where b.Cust_Bank_Id = v_Fundcode(i);
    
    /*新增*/
    insert into Cp_Cust_Bank_Acct_Info 
    (/*1~10*/
    CUST_BANK_ID, CUST_NO, BANK_CODE, BANK_REGION_CODE, BANK_REGION_NAME, PROV_CODE, CITY_CODE, BANK_ACCT, BANK_ACCT_NAME, BANK_ACCT_TYPE, 
    /*11~20*/
    BANK_ACCT_ATTR, PMT_STATUS, CUR_CODE, IS_DFLT, PAY_NO, BANK_ACCT_STATUS, MEMO, REC_STAT, CREATOR, MODIFIER, 
    /*21~30*/
    CHECKER, CHECK_FLAG, CRE_DT, MOD_DT, BANK_ACCT_VRFY_STAT, BANK_ACCT_BIND_STAT, ORIG_CUST_BANK_ID, BANK_ACCT_VRFY_MODE, ACCT_IDENTIFY_STAT, FEW_PMT_STAT, 
    /*31~40*/
    FEW_PMT_AMT, IDENTIFY_LOCK_DT, IDENTIFY_LOCK_TM, IDENTIFY_LOCK_TIMES, HB_PMT_OPEN_FLAG, YB_MOVE_STATUS, CARD_CHG_STATUS, OPEN_NO_CARD_PAY_STATUS, IS_PMT_CHG_CARD, IS_PMT_SIGN, 
    /*41~*/
    CCB_VERIFY_TIMES, IS_NEW_CARD, IS_YL_VERIFY, UPDATED_STIMESTAMP, MOBILE, MOBILE_VRFY_STAT, MOBILE_VRFY_STIMESTAMP, ICBC_BANK_ACCT_BIND_STAT)
    Values (
    /*1~10*/
    v_Fundcode(i) , v_Fundcode(i) || i, '308', '308100005027', '测试分行名称' || i, null, null, '622588121111111111', '测试银行账户名称' || i, ' ', 
    /*11~20*/
    '0', null, '156', '1', null, '0', ' ', '0', 'ssq', 'wb', 
    /*21~30*/
    'wb', '1', Dt, Dt, '2', '1', null, '2', '4', '1', 
    /*31~40*/
    0.29, null, null, null, null, '0', '0', '1', '1', '1', 
    /*41~*/
    0, '1', '1', Sysdate, null, null, null, '1');

  End Loop;
  
  Commit;
  
  /*交易申请清算表*/
  Dbms_Output.Put_Line('处理交易申请清算表');
  Delete From St_Trade_App_Settle Where Trade_Dt = Dt;
  Commit;
  Dbms_Output.Put_Line('删除交易申请清算表成功');
  
  /*新增 申请表*/
  Insert Into St_Trade_App_Settle (APP_SERIAL_NO, CONTRACT_NO, TRADE_DT, APP_CODE, TX_CODE, CUST_NO, INVST_TYPE, ID_TYPE, ID_NO, CUST_NAME, TX_APP_FLAG, TX_CHK_FLAG, TX_ACK_FLAG, TX_ACK_FLAG_BAK, TX_PMT_FLAG, TX_COMP_FLAG, TRADE_CHAN, REGION_CODE, OUTLET_CODE, BUSI_CODE, FUND_TX_ACCT_NO, TA_CODE, FUND_ACCT_NO, FUND_CODE, SHARE_CLASS, CURRENCY, APP_AMT, APP_VOL, TA_TRADE_DT, APP_DT, APP_TM, TRADE_TM, COMB_NO, CONS_CODE, RET_CODE, RET_MSG, CREATOR, CHECKER, STIMESTAMP, LARGE_REDM_FLAG, REDM_FLAG, ORI_APP_DT, ORI_APP_SERIAL_NO, VALID_PERIOD, ADVANCE_DAYS, ADVANCE_DT, TA_SERIAL_NO, ORI_TA_SERIAL_NO, ORI_ACK_DT, TAGENT_NO, TOUTLET_CODE, TREGION_CODE, TFUND_TX_ACCT_NO, TFUND_CODE, TSHARE_CLASS, FEE_RATE, DIV_MODE, DIV_RATIO, AGENT_DISC, TA_DISC, ACCT_PLAN_NO, PLAN_CODE, CUST_BANK_ID, TM_UNIT, INTERVAL, SAVING_PLAN_DT1, SAVING_PLAN_DT2, SAVING_PLAN_DT3, SAVING_PLAN_DT4, FUND_RISK_LEVEL, CUST_RISK_LEVEL, RISK_FLAG, ACK_VOL, ACK_AMT, REDM_LAST_VOL, REDM_LAST_VOL_BAK, NAV, TRADE_PRICE, TRANSACTOR, TRANSACTOR_ID_TYPE, TRANSACTOR_ID_NO, MEMO, PMT_URL, PMT_RSLT, PMT_DT, PMT_TM, PMT_SERIAL_NO, PMT_RET_CODE, PROTOCAL_END_DT, SAVING_TIMES, CAPT_NOTIFY_FLAG, ADVANCE_FLAG, BACKENLOAD_DISC, SHARE_REG_DT, DELAY_FLAG, SAVING_PLAN_NAME, 
       DIS_APP_SERIAL_NO, UPDATED_STIMESTAMP, TRANSFER_LAST_VOL, TRANSFER_LAST_VOL_BAK, TFUND_ACCT_NO, UNUSUAL_TRANS_TYPE, TRADE_SNO, PROD_ID, PROD_NAME, PURCHASE_DIRECTION, FROM_BUSI_CODE, SERVICE_FEE_RATE, SERVICE_FEE_DISC, PRE_REDE_AMT, PRE_REDE_NAV, PRE_REDE_NAV_DT)
  ( Select APP_SERIAL_NO,SEQ_CONTRACTNO.NEXTVAL CONTRACT_NO,TRADE_DT,'20','202010',CUST_NO,'1' ,'0','140101198001010091','测试', '0', '0', '4', '4', '2', '2', nvl(TRADE_CHAN,'2'),REGION_CODE, OUTLET_CODE, BUSI_CODE, FUND_TX_ACCT_NO, TA_CODE,FUND_ACCT_NO,FUND_CODE, 'A', '156',APP_AMT, APP_VOL, Dt, TRADE_DT, '100607', '100607', null, null, '0000', null, 'web', null,sysdate, null, null, null, null, 0, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, 1.0000, 1.0000, null, null, SEQ_CUSTBANKID.NEXTVAL, null, null, null, null, null, null, '5', '1', '1', null, null, 0.00000, 0.00000, null, null, null, null, null, null, null, null, TRADE_DT, '100607',SEQ_PMTCHKSERIALNO.NEXTVAL, null, null, null, null, '0', null, null, null, null, App_Serial_No, sysdate, 0.00000, 0.00000, null, null, null, null, null, null, null, null, null, null, null, NULL FROM 
    (
    Select a.App_Serial_No, a.Trade_Dt,a.Cust_No,a.Trade_Chan,a.Region_Code,a.Outlet_Code,a.Busi_Code,
           a.Fund_Tx_Acct_No,a.Ta_Code,a.Fund_Acct_No,a.Fund_Code,a.App_Amt,a.App_Vol
      From St_Trade_Ack_Settle a
     Where a.Trade_Dt = Dt
       And a.App_Serial_No Is Not Null
       And a.Busi_Code Not In ('142','143')
       /*去重*/
       /*And a.App_Serial_No In (Select Max(a.App_Serial_No)
                             From St_Trade_Ack_Settle a
                            Group By a.App_Serial_No)*/
    )
  );
  
  Commit;
  Dbms_Output.Put_Line('新增交易申请清算表成功');
  
  /*分销交易类委托明细清算表*/
  Dbms_Output.Put_Line('处理分销交易类委托明细清算表');
  Delete From St_Dis_Trade_App_Settle Where Trade_Dt = Dt;
  Commit;
  Dbms_Output.Put_Line('删除分销交易类委托明细清算表成功');
  
  /*新增 委托表*/
  Insert Into ST_DIS_TRADE_APP_SETTLE (DIS_APP_SERIAL_NO, CONTRACT_NO, TRADE_DT, APP_CODE, TX_CODE, CUST_NO, INVST_TYPE, ID_TYPE, ID_NO, CUST_NAME, TX_APP_FLAG, TX_CHK_FLAG, TX_ACK_FLAG, TX_PMT_FLAG, TX_COMP_FLAG, TRADE_CHAN, REGION_CODE, OUTLET_CODE, BUSI_CODE, FUND_TX_ACCT_NO, TA_CODE, FUND_ACCT_NO, FUND_CODE, SHARE_CLASS, CURRENCY, APP_AMT, APP_VOL, TA_TRADE_DT, APP_DT, APP_TM, TRADE_TM, COMB_NO, CONS_CODE, RET_CODE, RET_MSG, CREATOR, CHECKER, STIMESTAMP, LARGE_REDM_FLAG, REDM_FLAG, ORI_APP_DT, ORI_APP_SERIAL_NO, VALID_PERIOD, ADVANCE_DAYS, ADVANCE_DT, TA_SERIAL_NO, ORI_TA_SERIAL_NO, ORI_ACK_DT, TAGENT_NO, TOUTLET_CODE, TREGION_CODE, TFUND_TX_ACCT_NO, TFUND_CODE, TSHARE_CLASS, FEE_RATE, DIV_MODE, DIV_RATIO, AGENT_DISC, TA_DISC, ACCT_PLAN_NO, PLAN_CODE, CUST_BANK_ID, TM_UNIT, INTERVAL, SAVING_PLAN_DT1, SAVING_PLAN_DT2, SAVING_PLAN_DT3, SAVING_PLAN_DT4, FUND_RISK_LEVEL, CUST_RISK_LEVEL, RISK_FLAG, TRANSACTOR, TRANSACTOR_ID_TYPE, TRANSACTOR_ID_NO, MEMO, PMT_URL, PMT_RSLT, PMT_DT, PMT_TM, PMT_SERIAL_NO, PMT_RET_CODE, PROTOCAL_END_DT, SAVING_TIMES, ADVANCE_FLAG, BACKENLOAD_DISC, SHARE_REG_DT, DELAY_FLAG, SAVING_PLAN_NAME,
   DIS_CODE, DIS_FUND_TX_ACCT_NO, PROTOCAL_NO, TRANS_RATIO, TRANS_STATUS, IS_AUTO_REQUEST, REDM_LAST_VOL, TX_ACK_FLAG_BAK, REDM_LAST_VOL_BAK, BLOTTER_NO, TRANS_RATIO_BAK, TRANS_STATUS_BAK, UPDATED_STIMESTAMP, LOANING_CHANNEL_ID, TRANSFER_LAST_VOL, TRANSFER_LAST_VOL_BAK, TFUND_ACCT_NO, DEAL_TYPE, ACK_VOL, ACK_AMT, UNUSUAL_TRANS_TYPE, TRADE_SNO, PROD_ID, PROD_NAME, PURCHASE_DIRECTION, FROM_BUSI_CODE, SERVICE_FEE_RATE, SERVICE_FEE_DISC, PRE_REDE_AMT, PRE_REDE_NAV, PRE_REDE_NAV_DT)
  Select A.DIS_APP_SERIAL_NO, CONTRACT_NO, TRADE_DT, APP_CODE, TX_CODE, CUST_NO, INVST_TYPE, ID_TYPE, ID_NO, CUST_NAME, TX_APP_FLAG, TX_CHK_FLAG, TX_ACK_FLAG, TX_PMT_FLAG, TX_COMP_FLAG, TRADE_CHAN, REGION_CODE, OUTLET_CODE, BUSI_CODE, FUND_TX_ACCT_NO, TA_CODE, FUND_ACCT_NO, FUND_CODE, SHARE_CLASS, CURRENCY, APP_AMT, APP_VOL, TA_TRADE_DT, APP_DT, APP_TM, TRADE_TM, COMB_NO, CONS_CODE, RET_CODE, RET_MSG, CREATOR, CHECKER, STIMESTAMP, LARGE_REDM_FLAG, REDM_FLAG, ORI_APP_DT, ORI_APP_SERIAL_NO, VALID_PERIOD, ADVANCE_DAYS, ADVANCE_DT, TA_SERIAL_NO, ORI_TA_SERIAL_NO, ORI_ACK_DT, TAGENT_NO, TOUTLET_CODE, TREGION_CODE, TFUND_TX_ACCT_NO, TFUND_CODE, TSHARE_CLASS, FEE_RATE, DIV_MODE, DIV_RATIO, AGENT_DISC, TA_DISC, ACCT_PLAN_NO, PLAN_CODE, CUST_BANK_ID, TM_UNIT, INTERVAL, SAVING_PLAN_DT1, SAVING_PLAN_DT2, SAVING_PLAN_DT3, SAVING_PLAN_DT4, FUND_RISK_LEVEL, CUST_RISK_LEVEL, RISK_FLAG, TRANSACTOR, TRANSACTOR_ID_TYPE, TRANSACTOR_ID_NO, MEMO, PMT_URL, PMT_RSLT, PMT_DT, PMT_TM, PMT_SERIAL_NO, PMT_RET_CODE, PROTOCAL_END_DT, SAVING_TIMES, ADVANCE_FLAG, BACKENLOAD_DISC, SHARE_REG_DT, DELAY_FLAG, SAVING_PLAN_NAME,
         'HB000A001'/*好买*/,'X041008808059TXW00D001',seq_temp_id.nextval,'3','1','0',NULL,NULL,NULL,NULL,NULL,NULL , UPDATED_STIMESTAMP,'0004', TRANSFER_LAST_VOL, TRANSFER_LAST_VOL_BAK, TFUND_ACCT_NO,'1',ack_vol,ack_amt, UNUSUAL_TRANS_TYPE, TRADE_SNO, PROD_ID, PROD_NAME, PURCHASE_DIRECTION, FROM_BUSI_CODE, SERVICE_FEE_RATE, SERVICE_FEE_DISC, PRE_REDE_AMT, PRE_REDE_NAV, PRE_REDE_NAV_DT 
  From ST_TRADE_APP_SETTLE A Where a.Trade_Dt = Dt And a.Dis_App_Serial_No Like 'flct%' 
  And a.Busi_Code Not In ('142','143');
  
  Dbms_Output.Put_Line('新增非理财通分销交易类委托明细清算表成功');
  Commit;
  
  Insert Into ST_DIS_TRADE_APP_SETTLE (DIS_APP_SERIAL_NO, CONTRACT_NO, TRADE_DT, APP_CODE, TX_CODE, CUST_NO, INVST_TYPE, ID_TYPE, ID_NO, CUST_NAME, TX_APP_FLAG, TX_CHK_FLAG, TX_ACK_FLAG, TX_PMT_FLAG, TX_COMP_FLAG, TRADE_CHAN, REGION_CODE, OUTLET_CODE, BUSI_CODE, FUND_TX_ACCT_NO, TA_CODE, FUND_ACCT_NO, FUND_CODE, SHARE_CLASS, CURRENCY, APP_AMT, APP_VOL, TA_TRADE_DT, APP_DT, APP_TM, TRADE_TM, COMB_NO, CONS_CODE, RET_CODE, RET_MSG, CREATOR, CHECKER, STIMESTAMP, LARGE_REDM_FLAG, REDM_FLAG, ORI_APP_DT, ORI_APP_SERIAL_NO, VALID_PERIOD, ADVANCE_DAYS, ADVANCE_DT, TA_SERIAL_NO, ORI_TA_SERIAL_NO, ORI_ACK_DT, TAGENT_NO, TOUTLET_CODE, TREGION_CODE, TFUND_TX_ACCT_NO, TFUND_CODE, TSHARE_CLASS, FEE_RATE, DIV_MODE, DIV_RATIO, AGENT_DISC, TA_DISC, ACCT_PLAN_NO, PLAN_CODE, CUST_BANK_ID, TM_UNIT, INTERVAL, SAVING_PLAN_DT1, SAVING_PLAN_DT2, SAVING_PLAN_DT3, SAVING_PLAN_DT4, FUND_RISK_LEVEL, CUST_RISK_LEVEL, RISK_FLAG, TRANSACTOR, TRANSACTOR_ID_TYPE, TRANSACTOR_ID_NO, MEMO, PMT_URL, PMT_RSLT, PMT_DT, PMT_TM, PMT_SERIAL_NO, PMT_RET_CODE, PROTOCAL_END_DT, SAVING_TIMES, ADVANCE_FLAG, BACKENLOAD_DISC, SHARE_REG_DT, DELAY_FLAG, SAVING_PLAN_NAME,
   DIS_CODE, DIS_FUND_TX_ACCT_NO, PROTOCAL_NO, TRANS_RATIO, TRANS_STATUS, IS_AUTO_REQUEST, REDM_LAST_VOL, TX_ACK_FLAG_BAK, REDM_LAST_VOL_BAK, BLOTTER_NO, TRANS_RATIO_BAK, TRANS_STATUS_BAK, UPDATED_STIMESTAMP, LOANING_CHANNEL_ID, TRANSFER_LAST_VOL, TRANSFER_LAST_VOL_BAK, TFUND_ACCT_NO, DEAL_TYPE, ACK_VOL, ACK_AMT, UNUSUAL_TRANS_TYPE, TRADE_SNO, PROD_ID, PROD_NAME, PURCHASE_DIRECTION, FROM_BUSI_CODE, SERVICE_FEE_RATE, SERVICE_FEE_DISC, PRE_REDE_AMT, PRE_REDE_NAV, PRE_REDE_NAV_DT)
  Select A.DIS_APP_SERIAL_NO, CONTRACT_NO, TRADE_DT, APP_CODE, TX_CODE, CUST_NO, INVST_TYPE, ID_TYPE, ID_NO, CUST_NAME, TX_APP_FLAG, TX_CHK_FLAG, TX_ACK_FLAG, TX_PMT_FLAG, TX_COMP_FLAG, TRADE_CHAN, REGION_CODE, OUTLET_CODE, BUSI_CODE, FUND_TX_ACCT_NO, TA_CODE, FUND_ACCT_NO, FUND_CODE, SHARE_CLASS, CURRENCY, APP_AMT, APP_VOL, TA_TRADE_DT, APP_DT, APP_TM, TRADE_TM, COMB_NO, CONS_CODE, RET_CODE, RET_MSG, CREATOR, CHECKER, STIMESTAMP, LARGE_REDM_FLAG, REDM_FLAG, ORI_APP_DT, ORI_APP_SERIAL_NO, VALID_PERIOD, ADVANCE_DAYS, ADVANCE_DT, TA_SERIAL_NO, ORI_TA_SERIAL_NO, ORI_ACK_DT, TAGENT_NO, TOUTLET_CODE, TREGION_CODE, TFUND_TX_ACCT_NO, TFUND_CODE, TSHARE_CLASS, FEE_RATE, DIV_MODE, DIV_RATIO, AGENT_DISC, TA_DISC, ACCT_PLAN_NO, PLAN_CODE, CUST_BANK_ID, TM_UNIT, INTERVAL, SAVING_PLAN_DT1, SAVING_PLAN_DT2, SAVING_PLAN_DT3, SAVING_PLAN_DT4, FUND_RISK_LEVEL, CUST_RISK_LEVEL, RISK_FLAG, TRANSACTOR, TRANSACTOR_ID_TYPE, TRANSACTOR_ID_NO, MEMO, PMT_URL, PMT_RSLT, PMT_DT, PMT_TM, PMT_SERIAL_NO, PMT_RET_CODE, PROTOCAL_END_DT, SAVING_TIMES, ADVANCE_FLAG, BACKENLOAD_DISC, SHARE_REG_DT, DELAY_FLAG, SAVING_PLAN_NAME,
         'LCT00K001'/*理财通*/,'X041008808059TXW00D001',seq_temp_id.nextval,'3','1','0',NULL,NULL,NULL,NULL,NULL,NULL , UPDATED_STIMESTAMP,'0004', TRANSFER_LAST_VOL, TRANSFER_LAST_VOL_BAK, TFUND_ACCT_NO,'1',ack_vol,ack_amt, UNUSUAL_TRANS_TYPE, TRADE_SNO, PROD_ID, PROD_NAME, PURCHASE_DIRECTION, FROM_BUSI_CODE, SERVICE_FEE_RATE, SERVICE_FEE_DISC, PRE_REDE_AMT, PRE_REDE_NAV, PRE_REDE_NAV_DT 
  From ST_TRADE_APP_SETTLE A Where a.Trade_Dt = Dt And a.Dis_App_Serial_No Like 'lct%'
  And a.Busi_Code Not In ('142','143');
  
  Commit;
  Dbms_Output.Put_Line('新增理财通分销交易类委托明细清算表成功');
  
  
  
  
  Dbms_Output.Put_Line('成功!完毕!');
Exception
  When Others Then
    /*打印错误日志*/
    DBMS_OUTPUT.put_line('exception------');
    DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode); 
    DBMS_OUTPUT.put_line('sqlerrm : ' ||sqlerrm); 
    Rollback;
End Insertpressuretext;
/
