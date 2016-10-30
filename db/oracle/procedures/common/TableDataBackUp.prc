create or replace procedure TableDataBackUp(TableName in varchar2, BakTableName in varchar2, Owner in varchar2) Authid Current_User is

v_num_ori     number(10);
v_num_bk      number(10);

begin
  
  --check if table exists
  select count(1) into v_num_ori from all_tables 
  where TABLE_NAME = upper(TableName) and OWNER = upper(Owner);
  
  if(v_num_ori<>0) then
       --if table exists, backup table using TableName_BakName as new table name      
       --check if back up table name has been used
       select count(1) into v_num_bk from all_tables 
                where TABLE_NAME = upper(BakTableName) and OWNER = upper(Owner);
       if(v_num_bk<>0) then
          dbms_output.put_line('backup table already exists. Recreate the backup table '||BakTableName);
          execute immediate 'drop table '||BakTableName;    
       end if;
       execute immediate 'create table '||BakTableName||' as select * from '||TableName;         
  else
       dbms_output.put_line('Backing up table failed, the table '||TableName||' does Not exists');   
  end if;
  
  exception
    when others then
      dbms_output.put_line('exception------');
      DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode);
      DBMS_OUTPUT.put_line('sqlerrm : ' ||sqlerrm);
      rollback;

  
end TableDataBackUp;
/
