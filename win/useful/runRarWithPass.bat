@ECHO OFF
setlocal enabledelayedexpansion

rem p1=movie_home,p2=rar_bk_home
call rarWithPass.bat %~1 %~2 avi
echo 'avi done'
call rarWithPass.bat %~1 %~2 mp4
echo 'mp4 done'
call rarWithPass.bat %~1 %~2 flv
echo 'flv done'
call rarWithPass.bat %~1 %~2 rm
echo 'rm done'
call rarWithPass.bat %~1 %~2 rmvb
echo 'rmvb done'
call rarWithPass.bat %~1 %~2 mpg
echo 'mpg done'
call rarWithPass.bat %~1 %~2 mkv
echo 'mkv done'
call rarWithPass.bat %~1 %~2 wmv
echo 'wmv done'