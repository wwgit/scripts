 select v.sql_id,v.child_number,
 v.sql_text,
 v.elapsed_time,
 v.cpu_time,
 v.disk_reads,
 rank() over(order by v.elapsed_time desc) elapsed_rank
 from v$sql v
