set JAVA_HOME=C:\Java\jdk1.7.0_13
set CLASS_PATH=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar
set PATH=.;%JAVA_HOME%\bin;%PATH%

cd .\bin
start jmeter-server.bat -Dserver_port=3001
start jmeter-server.bat -Dserver_port=3002
rem start jmeter-server.bat -Dserver_port=3003
rem start jmeter-server.bat -Dserver_port=3004
rem start jmeter-server.bat -Dserver_port=3005
rem start jmeter-server.bat -Dserver_port=3006
rem start jmeter-server.bat -Dserver_port=3007
rem start jmeter-server.bat -Dserver_port=3008
rem start jmeter-server.bat -Dserver_port=3009
rem start jmeter-server.bat -Dserver_port=3010
rem start jmeter-server.bat -Dserver_port=3006