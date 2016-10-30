@echo off

setlocal enabledelayedexpansion

set user_name=%~1
set password=%~2
set db_bk_file_path=F:\work_home\notepadplus_work_home\db\oracle\db_bk
set db_bk_file_name=%~3
set oracle_bin_path=G:\Oracle\product\10.1.0\Client_1\BIN

%oracle_bin_path%\imp %user_name%/%password%@192.168.220.11:1521/hbqa full=y ignore=y file=%db_bk_file_path%\%db_bk_file_name%


impdp \'/ as sysdba\' directory=DUMP_DIR dumpfile=lpt4_XM128_trade_20151010-for-lpt_byleon.dmp remap_schema=LPT4_XM128_TRADE:LPT5_XM128_TRADE