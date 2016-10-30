#!/bin/bash

#expdp username/password directory=DUMP_DIR dump_file=project_name_desc.dmp tables=table1,table2,table3,table4...
#This script only supports single/multiple table exporting
#if multiple tables exporting, make sure table names are seperated by comma.
#$1=db user name
#$2=db password
#$3=project name
#$4=description
#$5=table1,table2,table3,table4
expdp $1/$2 directory=DUMP_DIR dumpfile=$3_$4.dmp tables=$5
