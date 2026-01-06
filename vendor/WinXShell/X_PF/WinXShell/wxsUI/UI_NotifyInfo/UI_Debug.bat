setlocal EnableDelayedExpansion

call :GetUIName "%cd%"
cd /d "%~dp0..\.."
call :GetWinXShell

call :WAITTIPS error 错误 "系统磁盘控件不足" 0
call :WAITTIPS error 错误 "系统磁盘控件不足" 0
call :WAITTIPS error 错误 "系统磁盘控件不足" 0

for /l %%i in (1,1,8) do (
     call :TIPS info 金币 "+!random!" %%i
)

call :WAITTIPS warn 金币 "金币超最大上限 -4294967295" 0
pause

goto :EOF


:WAITTIPS
start /wait %WinXShell% -jcfg wxsUI\%UIName%\main.jcfg -i %1 -t %2 -m "%~3"
goto :EOF

:TIPS
start %WinXShell% -jcfg wxsUI\%UIName%\main.jcfg -i %1 -t %2 -m "%~3" -p %4
start /wait %WinXShell% -code App:Sleep(800)
goto :EOF


:GetUIName
set UIName=%~n1
goto :EOF

:GetWinXShell
if exist x64\Debug\WinXShell.exe set WINXSHELL=x64\Debug\WinXShell.exe&&goto :EOF
if exist WinXShell.exe set WINXSHELL=WinXShell.exe&&goto :EOF
if exist WinXShell_%PROCESSOR_ARCHITECTURE%.exe set WINXSHELL=WinXShell_x86.exe&&goto :EOF
set WINXSHELL=WinXShell_x64.exe
goto :EOF
