@echo off
@cd c:\

@rem begin to clean files
@del /f %windir%\temp\*.* 

@del /f %windir%\Temporary Internet Files\*.* 

@del /f %windir%\History\*.* 

@del /f %windir%\Recent\*.* 

@del /f %windir%\Cookies\*.* 

@del /f %USERPROFILE%\AppData\Local\Temp\*.*

rem @del /f %USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache\*.*

rem @del /f %USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Media Cache\*rem.*

rem @del /f %USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache\*.*