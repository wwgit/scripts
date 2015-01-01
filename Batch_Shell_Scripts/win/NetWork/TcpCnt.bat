@echo off
rem enable variable delay
setlocal enabledelayedexpansion
rem date/t >> ./pingTest.txt
rem time/t >> ./pingTest.txt
rem :main
set conditon=%~1
set condition2=%~2
set status1=%~3
set status2=%~4
set interval=%~5
set expect_duration=%~6

set type=%expect_duration:~-1%
set begin_time=%time:~0,-3%


echo script begins at %begin_time%

echo type %type%
rem echo expect_duration %expect_duration%

if /i s == %type% ( 

	set expect_duration=!expect_duration:s=! 
	echo expect_duration !expect_duration!

) else if /i m == %type% ( 

   set expect_duration=!expect_duration:m=!
   set /a expect_duration=!expect_duration!*60 
   echo expect_duration !expect_duration!
   
) else if /i h == %type% (
   
   set expect_duration=!expect_duration:h=!
   set /a expect_duration=!expect_duration!*60*60    
   echo expect_duration !expect_duration!

) else (
   
   echo time format error
   goto:eof
)

echo folder checking:
if exist ./result  (
   echo folder exists
) else (
  mkdir result
)

rem get hour minute and second
for /f "tokens=1,2,3 delims=:" %%i in ("%begin_time%") do (

    set /a hour_b=%%i
    set /a minute_b=%%j
    set  /a second_b=%%k	
	
)

:mainloop
::echo mainloop begin:

set end_time=%time:~0,-3%
set end_time=!end_time: =!
echo %end_time%
for /f "tokens=1,2,3 delims=:" %%i in ("%end_time%") do (

    set /a hour_e=%%i
    set /a minute_e=%%j
    set /a second_e=%%k
	echo hour !hour_e! 
	echo minute !minute_e!
	echo second !second_e!

)

for /f %%a in ('netstat -aon ^| find "%conditon%" ^| find "%condition2%" ^| find "%status1%" /c') do (

   rem echo %conditon%
   echo %conditon%,%condition2%,%status1%,%%a,%end_time%>>./result/%conditon%_%condition2%_%status1%_%hour_b%%minute_b%%second_b%.txt
   
)

for /f %%a in ('netstat -aon ^| find "%conditon%" ^| find "%condition2%" ^| find "%status2%" /c') do (

   rem echo %conditon%
   echo %conditon%,%condition2%,%status2%,%%a,%end_time%>>./result/%conditon%_%condition2%_%status2%_%hour_b%%minute_b%%second_b%.txt
   
)

call :time_lapse

set  /a actual_duration=%second_%+%minute_%*60+%hour_%*60*60
echo actual_duration %actual_duration%

if %actual_duration% lss %expect_duration% (

   ping -n %interval% 127.0.0.1>nul
   goto:mainloop

)

goto:eof

:time_lapse
::calculation must starts from second

if %second_e% lss %second_b% (

    set /a minute_e=%minute_e%-1
	set /a second_e=%second_e%+60   
 )

set /a second_=%second_e%-%second_b%

if %minute_e% lss %minute_b% (

    set /a hour_e=%hour_e%-1
    set /a minute_e=%minute_e%+60

)

set /a minute_=%minute_e%-%minute_b%

if %hour_e% lss %hour_b% (

    set /a hour_e=%hour_e%+24

)

set /a hour_=%hour_e%-%hour_b%
goto:eof


