@echo off
setlocal enabledelayedexpansion

set mail_path=D:\Program Files\Foxmail 7.2\Storage
set project_path=F:\work_home\projects
set english_path=F:\work_home\EnglishTranslation
set winrar_path=D:\win_rar

d:

cd %winrar_path%
echo pwd

rem close mail process before running backing up script
tasklist | find /i "Foxmail" && taskkill /f /im "Foxmail.exe"

rem running backing up script
WinRAR.exe a \\192.168.230.15\chen.li\bak\chen.li%date:~0,4%%date:~5,2%.rar ^
"%mail_path%" "%english_path%"

