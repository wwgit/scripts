@echo off
setlocal enabledelayedexpansion

rem Reg path set
set RegTcpPath=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters
set RegAfdPath=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters
set TcpRegFile=%cd%\RegTcpBkUp.reg
set AfdRegFile=%cd%\RegAfdBkUp.reg

rem set default value here
rem create under HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters
set TcpTimedWaitDelay=30
set MaxFreeTcbs=16000
set MaxHashTableSize=65536
set MaxUserPort=65534
set /a KeepAliveInterval=1000*60*5
set /a KeepAliveTime=1000*60*30
set DefaultItems="TcpTimedWaitDelay,MaxFreeTcbs,MaxHashTableSize,MaxUserPort"

rem enable dynamic listen backlog length
rem create under HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters
set EnableDynamicBacklog=1
set MinimumDynamicBacklog=256
set MaximumDynamicBacklog=2048
set DynamicBacklogGrowthDelta=128

if "%1"=="-c" (

   if "%~2"=="" (
	    call RegUtil.bat Q %RegTcpPath% TcpTimedWaitDelay
        call RegUtil.bat Q %RegTcpPath%	MaxUserPort	
		goto:eof
	)
	call RegUtil.bat Q %RegTcpPath%	%2
	goto:eof

)

if "%1"=="-u" (
   rem backup first before update

   rem call :regExport %RegTcpPath% %TcpRegFile%
   rem call :regExport %RegAfdPath% %AfdRegFile%
   call RegUtil.bat B %RegTcpPath% %TcpRegFile%
   call RegUtil.bat B %RegAfdPath% %AfdRegFile%
   
   
   if "%~2"=="" (
   
      call :usage
	  goto:eof
   
   ) else (
      rem echo input num 2 is: %2
      call :UpdateLoop %2	  
	  goto:eof
   )

)

if "%1"=="-d" (

   rem call :regExport %RegTcpPath% %TcpRegFile%
   rem call :regExport %RegAfdPath% %AfdRegFile%
   call RegUtil.bat B %RegTcpPath% %TcpRegFile%
   call RegUtil.bat B %RegAfdPath% %AfdRegFile%
   
   if "%~2"=="" (

	   rem echo %DefaultItems%
	   call :DefaultLoop %DefaultItems% 
	   
	   goto:eof
   ) else (
       call :DefaultLoop %2
   )
)

if "%1"=="-r" (

   echo begin to recover reg conf from file
   if "%~2"=="" (
       rem call :RegRecover %TcpRegFile%
	   rem call :RegRecover %AfdRegFile%
	   call RegUtil.bat R %TcpRegFile%
	   call RegUtil.bat R %AfdRegFile%
	   goto:eof
	   
   ) else (
      rem call :RegRecover %2
	  call RegUtil.bat R %2
	  goto:eof
   )

)

if "%1"=="-b" (

   echo begin to backup reg conf from file
   if "%~2"=="TCP" (
   
      if "%~3"=="" (
           rem call :regExport %RegTcpPath% %TcpRegFile%
		   call RegUtil.bat B %RegTcpPath% %TcpRegFile%
		   goto:eof
	   ) else ( 
	       rem call :regExport %RegTcpPath% %3
		   call RegUtil.bat B %RegTcpPath% %3
		   goto:eof
	   )	   
   ) 
   
   if "%~2"=="AFD" (
   
      if "%~3"=="" (
          rem  call :regExport %RegAfdPath% %AfdRegFile%
		   call RegUtil.bat B %RegAfdPath% %AfdRegFile%
		   goto:eof
	   ) else ( 
	      rem  call :regExport %RegTcpPath% %3 
		   call RegUtil.bat B %RegTcpPath% %3
	       goto:eof
	   )	   
   )
   if "%~2"=="" ( 
   
     rem call :regExport %RegTcpPath% %TcpRegFile%
     rem call :regExport %RegAfdPath% %AfdRegFile%
	 
	 call RegUtil.bat B %RegTcpPath% %TcpRegFile%
	 call RegUtil.bat B %RegAfdPath% %AfdRegFile%
     goto:eof
	 
   )

)

goto:eof

rem  function definition starts from here:
:usage

echo here is the usage !

goto:eof

:UpdateLoop iVar
rem echo in valset
	for /f "tokens=1,* delims=," %%i in ("%~1") do (
         rem echo command is: %%i
		 rem echo rest command is: %%j
		 rem echo input par is: %1
		for /f "tokens=1,2 delims==" %%a in ("%%~i") do (
			call :UpdateAsPerCmd "%%a" "%%b"
			 rem echo %%a %%b
		)

		call :UpdateLoop "%%j"

	)

goto:eof

:DefaultLoop iVar

   for /f "tokens=1,* delims=," %%a in ("%~1") do (
        echo item is %%a
	    echo rest item is %%b
	   call :UpdateAsPerDefault "%%a"
	   call :DefaultLoop "%%b"
   
   )


goto:eof

:UpdateAsPerCmd iCmd, iValue

  if "%~1"=="ttwd" (
     set TcpTimedWaitDelay=%~2
     echo setting TcpTimedWaitDelay as %~2
	 rem call :regUpdate %RegTcpPath% TcpTimedWaitDelay REG_DWORD %2
	 call RegUtil.bat A %RegTcpPath% TcpTimedWaitDelay REG_DWORD %2
  )

  if "%~1"=="mup" (
     set set MaxUserPort=%~2
     echo setting MaxUserPort as %~2
	 rem call :regUpdate %RegTcpPath% MaxUserPort REG_DWORD %2.
	 call RegUtil.bat A %RegTcpPath% MaxUserPort REG_DWORD %2
  )

  if "%~1"=="mft" (
     set set MaxFreeTcbs=%~2
     echo setting MaxFreeTcbs as %~2
	 rem call :regUpdate %RegTcpPath% MaxFreeTcbs REG_DWORD %2
	 call RegUtil.bat A %RegTcpPath% MaxFreeTcbs REG_DWORD %2
  )

  if "%~1"=="mhts" (
     set set MaxHashTableSize=%~2
     echo setting MaxHashTableSize as %~2
	 rem call :regUpdate %RegTcpPath% MaxHashTableSize REG_DWORD %2
	 call RegUtil.bat A %RegTcpPath% MaxHashTableSize REG_DWORD %2
  )

  if "%~1"=="kai" (
     set set KeepAliveInterval=%~2
     echo setting KeepAliveInterval as %~2
	 rem call :regUpdate %RegTcpPath% KeepAliveInterval REG_DWORD %2
	 call RegUtil.bat A %RegTcpPath% KeepAliveInterval REG_DWORD %2
  )

  if "%~1"=="kat" (
     set set KeepAliveTime=%~2
     echo setting KeepAliveTime as %~2
	 rem call :regUpdate %RegTcpPath% KeepAliveTime REG_DWORD %2
	 call RegUtil.bat A %RegTcpPath% KeepAliveTime REG_DWORD %2
  )
  
  if "%~1"=="edbl" (
     set set EnableDynamicBacklog=%~2
     echo setting EnableDynamicBacklog as %~2
	 rem call :regUpdate %RegAfdPath% EnableDynamicBacklog REG_DWORD %2
	 call RegUtil.bat A %RegAfdPath% EnableDynamicBacklog REG_DWORD %2
  )
  
  if "%~1"=="mndbl" (
     set set MinimumDynamicBacklog=%~2
     echo setting MinimumDynamicBacklog as %~2
	 rem call :regUpdate %RegAfdPath% MinimumDynamicBacklog REG_DWORD %2
	 call RegUtil.bat A %RegAfdPath% MinimumDynamicBacklog REG_DWORD %2
  )
  
  if "%~1"=="mxdbl" (
     set set MaximumDynamicBacklog=%~2
     echo setting MaximumDynamicBacklog as %~2
	 rem call :regUpdate %RegAfdPath% MaximumDynamicBacklog REG_DWORD %2
	 call RegUtil.bat A %RegAfdPath% MaximumDynamicBacklog REG_DWORD %2
  )
  
  if "%~1"=="dbgd" (
     set set DynamicBacklogGrowthDelta=%~2
     echo setting DynamicBacklogGrowthDelta as %~2
	 rem call :regUpdate %RegAfdPath% DynamicBacklogGrowthDelta REG_DWORD %2
	 call RegUtil.bat A %RegAfdPath% DynamicBacklogGrowthDelta REG_DWORD %2
  )
  

 rem  echo Update As per Command done

goto:eof

:UpdateAsPerDefault iStr

 if "%~1"=="TcpTimedWaitDelay" (
    rem  set TcpTimedWaitDelay=%~2
     echo setting default TcpTimedWaitDelay %TcpTimedWaitDelay%
	 rem call :regUpdate %RegTcpPath% TcpTimedWaitDelay REG_DWORD %TcpTimedWaitDelay%
	 call RegUtil.bat A %RegTcpPath% TcpTimedWaitDelay REG_DWORD %TcpTimedWaitDelay%
  )
  
 if "%~1"=="MaxFreeTcbs" (
    rem  set TcpTimedWaitDelay=%~2
     echo setting default MaxFreeTcbs %MaxFreeTcbs%
	 rem call :regUpdate %RegTcpPath% MaxFreeTcbs REG_DWORD %MaxFreeTcbs%
	 call RegUtil.bat A %RegTcpPath% MaxFreeTcbs REG_DWORD %MaxFreeTcbs%
  )

 if "%~1"=="MaxHashTableSize" (
    rem  set TcpTimedWaitDelay=%~2
     echo setting default MaxHashTableSize %MaxHashTableSize%
	 rem call :regUpdate %RegTcpPath% MaxHashTableSize REG_DWORD %MaxHashTableSize%
	 call RegUtil.bat A %RegTcpPath% MaxHashTableSize REG_DWORD %MaxHashTableSize%
  )

 if "%~1"=="MaxUserPort" (
    rem  set TcpTimedWaitDelay=%~2
     echo setting default MaxUserPort %MaxUserPort%
	 rem call :regUpdate %RegTcpPath% MaxUserPort REG_DWORD %MaxUserPort%
	 call RegUtil.bat A %RegTcpPath% MaxUserPort REG_DWORD %MaxUserPort%
  )
  
  if "%~1"=="KeepAliveInterval" (
    rem  set TcpTimedWaitDelay=%~2
     echo setting default KeepAliveInterval %KeepAliveInterval%
	 rem call :regUpdate %RegTcpPath% KeepAliveInterval REG_DWORD %KeepAliveInterval%
	 call RegUtil.bat A %RegTcpPath% KeepAliveInterval REG_DWORD %KeepAliveInterval%
  )
  
  if "%~1"=="KeepAliveTime" (
    rem  set TcpTimedWaitDelay=%~2
     echo setting default KeepAliveTime %KeepAliveTime%
	 rem call :regUpdate %RegTcpPath% KeepAliveTime REG_DWORD %KeepAliveTime%
	 call RegUtil.bat A %RegTcpPath% KeepAliveTime REG_DWORD %KeepAliveTime%
  )

  if "%~1"=="EnableDynamicBacklog" (
    rem  set TcpTimedWaitDelay=%~2
     echo setting default EnableDynamicBacklog %EnableDynamicBacklog%
	 rem call :regUpdate %RegAfdPath% EnableDynamicBacklog REG_DWORD %EnableDynamicBacklog%
	 call RegUtil.bat A %RegAfdPath% EnableDynamicBacklog REG_DWORD %EnableDynamicBacklog%
  )
  
  if "%~1"=="MinimumDynamicBacklog" (
    rem  set TcpTimedWaitDelay=%~2
     echo setting default MinimumDynamicBacklog %MinimumDynamicBacklog%
	 rem call :regUpdate %RegAfdPath% MinimumDynamicBacklog REG_DWORD %MinimumDynamicBacklog%
	 call RegUtil.bat A %RegAfdPath% MinimumDynamicBacklog REG_DWORD %MinimumDynamicBacklog%
  )
   
  if "%~1"=="MaximumDynamicBacklog" (
    rem  set TcpTimedWaitDelay=%~2
     echo setting default MaximumDynamicBacklog %MaximumDynamicBacklog%
	 rem call :regUpdate %RegAfdPath% MaximumDynamicBacklog REG_DWORD %MaximumDynamicBacklog%
	 call RegUtil.bat A %RegAfdPath% MaximumDynamicBacklog REG_DWORD %MaximumDynamicBacklog%
  )
  
  if "%~1"=="DynamicBacklogGrowthDelta" (
    rem  set TcpTimedWaitDelay=%~2
     echo setting default DynamicBacklogGrowthDelta %DynamicBacklogGrowthDelta%
	rem  call :regUpdate %RegAfdPath% DynamicBacklogGrowthDelta REG_DWORD %DynamicBacklogGrowthDelta%
	 call RegUtil.bat A %RegAfdPath% DynamicBacklogGrowthDelta REG_DWORD %DynamicBacklogGrowthDelta%
  )
  
goto:eof

