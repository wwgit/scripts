@echo off

setlocal enabledelayedexpansion

set user_name=%~1
set password=%~2
set db_bk_file_path=F:\work_home\notepadplus_work_home\db\oracle\db_bk
set db_bk_file_name=%~3
set oracle_bin_path=G:\Oracle\product\10.1.0\Client_1\BIN

%oracle_bin_path%\exp %user_name%/%password%@192.168.220.11:1521/hbqa full=y file=%db_bk_file_path%\%db_bk_file_name%