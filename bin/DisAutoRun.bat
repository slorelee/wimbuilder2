rem Disable execution of AutoRun commands from registry
set NeedCmdWarpper=0
reg query "HKCR\SOFTWARE\Microsoft\Command Processor" /v Autorun 1>nul 2>nul
if %errorlevel% EQU 0 set "NeedCmdWarpper=1" && goto :LoadCmdWarpper
reg query "HKLM\SOFTWARE\Microsoft\Command Processor" /v Autorun 1>nul 2>nul
if %errorlevel% EQU 0 set "NeedCmdWarpper=1"
if "%NeedCmdWarpper%"=="0" (
  set NeedCmdWarpper=
  goto :EOF
)

:LoadCmdWarpper
set NeedCmdWarpper=
rem set "ComSpec_Org=%ComSpec%"
set ComSpec=cmdWrapper.exe
for /f %%i in ('rem cache for_f_cmd') do rem nothing
rem set "ComSpec=%ComSpec_Org%"
rem set ComSpec_Org=
