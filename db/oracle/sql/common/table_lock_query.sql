SELECT l.session_id sid, s.serial#, l.locked_mode,l.oracle_username,
 
����l.os_user_name,s.machine, s.terminal, o.object_name, s.logon_time
 
����FROM v$locked_object l, all_objects o, v$session s
 
����WHERE l.object_id = o.object_id
 
����AND l.session_id = s.sid
 
����ORDER BY sid, s.serial# ;





SELECT
   A.OWNER,                        --OBJECT�����û�
   A.OBJECT_NAME,                  --OBJECT���ƣ�������
   B.XIDUSN,
   B.XIDSLOT,
   B.XIDSQN,
   B.SESSION_ID,                   --�����û���session
   B.ORACLE_USERNAME,              --�����û���Oracle�û���
   B.OS_USER_NAME,                 --�����û��Ĳ���ϵͳ��½�û���
   B.PROCESS,
   B.LOCKED_MODE, 
   C.MACHINE,                      --�����û��ļ�������ƣ����磺WORKGROUP\UserName��
   C.STATUS,                       --����״̬
   C.SERVER,
   C.SID,
   C.SERIAL#,
   C.PROGRAM                       --�����û����õ����ݿ�����ߣ����磺ob9.exe��
 FROM
   ALL_OBJECTS A,
   V$LOCKED_OBJECT B,
   SYS.GV_$SESSION C 
 WHERE
   A.OBJECT_ID = B.OBJECT_ID
   AND B.PROCESS = C.PROCESS
   and A.OWNER='CUST'
   
   
   select count(*) from v$locked_object
   
   select b.owner,b.object_name,a.session_id,a.locked_mode 
   from v$locked_object a,dba_objects b where b.object_id = a.object_id;
   
   
   
SELECT LPAD(' ', DECODE(L.XIDUSN, 0, 3, 0)) || L.ORACLE_USERNAME 

USER_NAME, 

O.OWNER, 

O.OBJECT_NAME, 

O.OBJECT_TYPE, 
       
S.SID, 
       
S.SERIAL#;  

  

FROM V$LOCKED_OBJECT L, DBA_OBJECTS O, V$SESSION S 

 WHERE L.OBJECT_ID = O.OBJECT_ID 

   

AND L.SESSION_ID = S.SID  

 ORDER BY O.OBJECT_ID, XIDUSN DESC  

 SELECT
  A.OWNER,                        --OBJECT�����û�
  A.OBJECT_NAME,                  --OBJECT���ƣ�������
  B.XIDUSN,
  B.XIDSLOT,
  B.XIDSQN,
  B.SESSION_ID,                   --�����û���session
  B.ORACLE_USERNAME,              --�����û���Oracle�û���
  B.OS_USER_NAME,                 --�����û��Ĳ���ϵͳ��½�û���
  B.PROCESS,
  B.LOCKED_MODE, 
  C.MACHINE,                      --�����û��ļ�������ƣ����磺WORKGROUP\UserName��
  C.STATUS,                       --����״̬
  C.SERVER,
  C.SID,
  C.SERIAL#,
  C.PROGRAM                       --�����û����õ����ݿ�����ߣ����磺ob9.exe��
FROM
  ALL_OBJECTS A,
  V$LOCKED_OBJECT B,
  SYS.GV_$SESSION C 
WHERE
  A.OBJECT_ID = B.OBJECT_ID
  AND B.PROCESS = C.PROCESS
