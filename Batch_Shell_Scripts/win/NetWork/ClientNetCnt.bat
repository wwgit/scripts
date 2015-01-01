@echo off
setlocal enabledelayedexpansion

if "%1"=="" (
   set condition=80
) else (
   set condition=%~1
)

rem echo hello

if "%2"=="" (
  set interval=30 
) else (
  set interval=%~2
)

if "%3"=="" (

  set duration=30m
  
) else (

   set duration=%~3
)

if "%4"=="" (

  set status1=TIME_WAIT

) else (

  set status1=%~4

)

./TcpCnt.bat %condition% TCP ESTABLISHED %status1% %interval% %duration%






