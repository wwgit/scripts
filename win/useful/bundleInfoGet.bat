@ECHO OFF
setlocal enabledelayedexpansion

FOR /R plugins %%R IN (*.jar) do (

	rem echo "%%R"|findstr /v ".*source.*jar"
	FOR /F "delims=\ tokens=4" %%i in ('echo %%R^|findstr /v ".*source.*jar"') do (
	
		 set str=%%i
		 rem echo i=%%i
		 set str=!str:~0,-4!
		 FOR /F "delims=_ tokens=1,2" %%m in ('echo !str!') do (
			rem echo m=%%m
			rem echo n=%%n
			set finalstr=%%m,%%n
		 )
		 echo !finalstr!,plugins/%%i,4,false>>tmp.txt
	
	)

)

