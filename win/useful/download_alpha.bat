@echo off
setlocal enabledelayedexpansion

rem file server address
set download_frm_url=http://10.15.88.14:10080

rem set create dir of current date
set curr_date=%date:~0,4%%date:~5,2%%date:~8,2%

rem echo %curr_date%
if not exist E:\test_alpha\bk\%curr_date% (
  echo 'dir not exist'
  mkdir E:\test_alpha\bk\%curr_date%
)

if exist *.war.* (
	echo backup old war file to 'E:\test_alpha\bk\%curr_date%'
	move *.war.* E:\test_alpha\bk\%curr_date%
)

rem mktact relative path for test alpha
set mktact_path=/mktact_alpha_download/mktact.war

rem mktact intranet app relative path for test alpha
set intranet_path=/mkt_intranet_alpha_download/intranet.war

rem open acct remind relative path for test alpha
set openacct_path=/openacct_alpha_download/openAcctRemind.war

rem cmobile relative path for test alpha
set cmobile_path=/cmobile_alpha_download/cmobile.war

wget -P E:\test_alpha %download_frm_url%%mktact_path%

wget -P E:\test_alpha %download_frm_url%%intranet_path%

wget -P E:\test_alpha %download_frm_url%%openacct_path%

wget -P E:\test_alpha %download_frm_url%%cmobile_path%
