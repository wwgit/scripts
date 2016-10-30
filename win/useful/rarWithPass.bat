@ECHO OFF
setlocal enabledelayedexpansion

SET RAR_BAK_HOME=%~2
SET MOVIE_NAME=
SET MOVIE_DATE=
SET MOVIE_FULL_NAME=
SET OLD_PATH=

IF "%RAR_BAK_HOME%"=="" (
	ECHO RAR_BAK_HOME NOT SET YET !
	ECHO Please input a target dir name as rar file bak home !
	SET /p RAR_BAK_HOME=
)

IF NOT EXIST %RAR_BAK_HOME% MD %RAR_BAK_HOME%

rem checking dir and movie name format using ruby
d:\360sych\360sych\Ruby\file_name_format_validate.rb %~1

ECHO digging files in %~1...

rem %~3 is file extension you want to digging
call :batchAddRarWithExt %~1 %RAR_BAK_HOME% ww0445465674 %~3
rem pause
goto:eof


:batchAddRarWithExt iDirFullName,iTargetRootDir,iRarPassword,iExtention
FOR /R %~1 %%i IN (*.%~4) do (

	rem handle date 
	set MOVIE_DATE=%%~ti
	set MOVIE_DATE=!MOVIE_DATE:/=_!
	set MOVIE_DATE=!MOVIE_DATE:~0,7!
	
	
	rem create dir if not exist
    call :dirBuild %%i %~2
	
	FOR /F "delims=: tokens=1*" %%a IN ('echo %%i') do (
		echo handling new movie %%i
		echo target dir is %~2%%~pb%~4...
	    IF NOT EXIST %~2%%~pb%~4_!MOVIE_DATE!.txt ( 
			echo txt not exists ... calling runRar function directly...
			rem :runRar iChkTxt,iTargetMovie,iRarPassword,iTargetRar,iResult
			call :runRar %~2%%~pb%~4_!MOVIE_DATE!.txt %%i %3 %~2%%~pb%~4_!MOVIE_DATE!.rar,""
		)
		IF EXIST %~2%%~pb%~4_!MOVIE_DATE!.txt (
		  echo txt exists ... calling alreadyRar function...
		  call :alreadyRar %~2%%~pb%~4_!MOVIE_DATE!.txt,%%i,%~3,%~2%%~pb%~4_!MOVIE_DATE!.rar
		)	
	)
    	
)
echo end of batch add movie into rars
goto:eof


:dirBuild iDirFullName,iTargetRootDir
	
    rem echo %~2%~p1
	rem echo %~z1
    IF NOT EXIST %~2%~p1 MD %~2%~p1

goto:eof

:alreadyRar iChkTxt,iTargetMovie,iRarPassword,iTargetRar

set result=
	FOR /F "delims= tokens=*" %%y IN (%~1) DO (
	    rem echo read new line contents: %%y in %~1
		rem echo find str %%y|findstr "%~nx2"		
		FOR /F "delims= tokens=*" %%a IN ('echo %%~y^|findstr "%~nx2"') DO (
			rem echo find str is %%a in %1
			set result=%%a
			goto:_break 
			rem echo result is !result!			
		)		
		rem echo one line read end
	)
:_break	
call :runRar %1,%2,%3,%4,!result!
	
goto:eof


:runRar iChkTxt,iTargetMovie,iRarPassword,iTargetRar,iResult

	if "%~5"=="" (
		echo movie not found in related txt
		echo beginning to writing content %~2 into %~1
		echo %~2 >> %~1
		rem %3=pwd,%4=target_rar %2=target_movie
		echo beginning to add movie to rar...
		WinRAR.exe a -ep -p%~3 %~4 %~2
		echo adding movie to rar complete !
		
	) else (
		echo movie has already been added into related rar
	)

goto:eof