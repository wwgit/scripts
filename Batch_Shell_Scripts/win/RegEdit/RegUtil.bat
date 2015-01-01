@echo off
setlocal enabledelayedexpansion

if "%1"=="" (

   goto:usage

)

if "%1"=="Q" (

   if "%~2"=="" (
       goto:usage 
	 )
   if "%~3"=="" (
       goto:usage 
	 )
	
   set regPath=%~2
   set QueryItemName=%~3
   
   call :regQuery !regPath! !QueryItemName!

)

if "%1"=="A" (

   if "%~2"=="" (
       goto:usage 
	 )
   if "%~3"=="" (
       goto:usage 
	 )
   if "%~4"=="" (
       goto:usage 
	 )
   if "%~5"=="" (
       goto:usage 
	 )
	
   set regPath=%~2
   set UpdateItemName=%~3
   set ItemType=%~4
   set ItemValue=%~5
  rem  iPath, iItemName ,iType, iItemValue
   call :regUpdate !regPath! !UpdateItemName! !ItemType! !ItemValue!

)

if "%1"=="B" (

   if "%~2"=="" (
       goto:usage 
	 )
   if "%~3"=="" (
       goto:usage 
	 )
   
   set keyName=%~2
   set fileNameWithPath=%~3
   call :regExport !keyName! !fileNameWithPath!

)

if "%1"=="R" (

    if "%~2"=="" (
       goto:usage 
	 )
	
    set fileNameWithPath=%~2
    call :regRecover !fileNameWithPath!	
)

if "%1"=="D" (

   if "%2"=="" (
       goto:usage 
	 )
   if "%3"=="" (
       goto:usage 
	 )
    
	echo folder checking:
	if exist ./reg_del_bk  (
	   echo folder exists
	) else (
	  mkdir reg_del_bk
    )	
	
	set regPath=%~2
    set DelItemName=%~3
	echo item is !DelItemName!
	echo path is !regPath!
	
	call :regExport !regPath! %cd%\reg_del_bk\!DelItemName!_bak.reg
	call :regDel !regPath! !DelItemName!

)

goto:eof

rem  function definition starts from here:
:usage

echo here is the usage !

goto:eof

rem registration table operation starts from here:
:regQuery iPath, iItemName

   for /f "eol=H tokens=*" %%a in ('reg query "%~1" /v "%~2" /t REG_DWORD /z') do (
            echo %~2 found: %%a
          for /f "tokens=1,4" %%i in ("%%~a") do ( 
                   if "%%~i"=="%~2" (
				        set /a dec=%%j
				        echo %~2's decimal value is !dec!
				   )
		  )
   )

goto:eof

:regExport iKeyName, iFileName
      
	  echo reg table back up!
      reg export "%~1" "%~2" /y
	  

goto:eof

:regUpdate iPath, iItemName, iType, iItemValue

    reg add "%~1" /v "%~2" /t "%~3" /d "%~4" /f

goto:eof

:regRecover iFileNameWithPath

   echo reg table recovering !
    reg import "%~1"

goto:eof

:regDel iPath, iItemName

   echo begin to delete %2 !
   reg delete "%~1" /v "%~2" /f

goto:eof