create or replace procedure TableDataRecover(TableName in varchar2, BakTableName in varchar2, Owner in varchar2) Authid Current_User is

v_num_bk     number(10);
v_num_ori    number(10);

begin
  
v_num_bk:=0;
v_num_ori:=0;
  
  --check if table exists
  select count(1) into v_num_bk from all_tables 
         where TABLE_NAME = upper(BakTableName) and OWNER = upper(Owner);
 --check if table bak exists
  if(v_num_bk<>0) then
       --if table exists,  as new table name
       dbms_output.put_line('Backing up table exists, continue to recover data from bak table '||BakTableName);
       
       --check if table exists
       select count(1) into v_num_ori from all_tables 
              where TABLE_NAME = upper(TableName) and OWNER = upper(Owner); 
       if(v_num_ori<>0) then
           execute immediate 'drop table '||TableName;
           execute immediate  'create table '||TableName||' as
           select * from '||BakTableName;
       else
           execute immediate  'create table '||TableName||' as
           select * from '||BakTableName;
       end if;
       dbms_output.put_line('Recovering table '||TableName||' Done !');
  else
       dbms_output.put_line('Recovering table data failed, the backup table '||BakTableName||' does Not exists');   
  end if;

exception
    when others then
      dbms_output.put_line('exception------');
      DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode);
      DBMS_OUTPUT.put_line('sqlerrm : ' ||sqlerrm);
      rollback;
  
end TableDataRecover;
/
