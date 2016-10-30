CREATE OR REPLACE PROCEDURE P_cursor_usage_Proc IS

VTpName   varchar2(32);

--declare
v_owner dba_tables.owner%type;
 -- type definition
 --  cursor cc is select outlet_code from tp_deal_operate_rec where rownum<50;
 cursor ci is SELECT distinct n.INDEX_NAME,n.table_name FROM DBA_INDEXES n WHERE n.TABLESPACE_NAME='TRADE';

  cursor_index ci%rowtype;

 -- cursor variable definition

  
begin

  
   for cursor_index in ci loop
     
    DBMS_OUTPUT.put_line(dbms_metadata.get_ddl(object_type=>'INDEX',name=>cursor_index.INDEX_NAME));
    
   end loop;

exception
    when others then
      dbms_output.put_line('exception------');
      DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode);
      DBMS_OUTPUT.put_line('sqlerrm : ' ||sqlerrm);
      rollback;

END P_cursor_usage_Proc;
/
