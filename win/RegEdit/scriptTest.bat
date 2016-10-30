@echo off

for /f "tokens=*" %%i in ('reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters
                           /v TcpTimedWaitDelays /t REG_DWORD' ) do (
      echo i is %%i
)

			for /f "tokens=1,3" %%i in (%%a) do (
			         
			)