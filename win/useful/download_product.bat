@echo off
setlocal enabledelayedexpansion

rem file server address
set download_frm_url=http://10.15.88.14:10080

rem set create dir of current date
set curr_date=%date:~0,4%%date:~5,2%%date:~8,2%

rem echo %curr_date%
if not exist E:\production\bk\%curr_date% (
  echo 'bk dir not exist'
  mkdir E:\production\bk\%curr_date%
)

if exist *.war.* (
	echo backup old war file to 'E:\production\bk\%curr_date%'
	move *.war.* E:\production\bk\%curr_date%
)

rem mktact relative path for production
set mktact_path=/mktact_product_download/mktact.war

rem mktact intranet app relative path for production
set intranet_path=/mkt_intranet_product_download/intranet.war

rem open acct remind relative path for production
set openacct_path=/openacct_product_download/openAcctRemind.war

rem cmobile relative path for production
set cmobile_path=/cmobile_product_download/cmobile.war

wget -P E:\production %download_frm_url%%mktact_path%

wget -P E:\production %download_frm_url%%intranet_path%

wget -P E:\production %download_frm_url%%openacct_path%

wget -P E:\production %download_frm_url%%cmobile_path%
