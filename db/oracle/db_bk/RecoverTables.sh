#!/bin/bash

#impdp new_db_user/new_db_pwd directory=DUMP_DIR dumpfile=projectName_Desc.dmp tables=table1,table2,table3 remap_schema=old_db_schema:new_db_schema
#param1=new_db_user
#param2=new_db_pwd
#param3=dump_file_name
#param4=old_schema
#param5=tableName1,tableName2....


#param1 is orgin string; param2 is separator to cut the string
strSplit() {

  local array=;
  array=`echo "$1"|awk -F $2 'END{for(i=1;i<=NF;i++){print $i}}'`
  echo $array

}

#handles format
tableNameArr=(`strSplit $5 ,`)

#str to save valid table name string
table_string=
i=0

#echo arry ele is ${#tableNameArr[@]}
#old_schema.tablename,old_schema.talbename2...
for tableName in ${tableNameArr[@]}
do   
	table_string=$table_string$4.$tableName 
	((i++))
	if [ $i -lt ${#tableNameArr[@]} ]
	then
		table_string=$table_string,	
	fi
done

#echo $table_string

#based on above instruction and assume that param1=param5 new_db_user=new_db_schema
impdp $1/$2 directory=DUMP_DIR dumpfile=$3 tables=$table_string remap_schema=$4:$1
