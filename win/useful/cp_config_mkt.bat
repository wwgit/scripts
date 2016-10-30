@echo off
setlocal enabledelayedexpansion

rem better use latest tags
set source_dir="E:\SVN_TEST\tags\V2.9.7"

set target_dir="E:\SVN_TEST\tags\V2.9.8"
set relative_dir="src\main\resources\env\production"

xcopy %source_dir%\GwInetAct-cmobile\%relative_dir% %target_dir%\GwInetAct-cmobile\%relative_dir% /e/h

xcopy %source_dir%\GwMktact\%relative_dir% %target_dir%\GwMktact\%relative_dir% /e/h

xcopy %source_dir%\GwMktact-intranet-app\%relative_dir% %target_dir%\GwMktact-intranet-app\%relative_dir% /e/h

xcopy %source_dir%\GwOpenAcct-remind\%relative_dir% %target_dir%\GwOpenAcct-remind\%relative_dir% /e/h