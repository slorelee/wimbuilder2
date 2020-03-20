@echo off

rem hide this console window
if exist "%ProgramFiles%\WinXShell\WinXShell.exe" (
  title PE_STARTNET_WINDOW
  "%ProgramFiles%\WinXShell\WinXShell.exe" -luacode "HideWindow('ConsoleWindowClass', 'PE_STARTNET_WINDOW')"
)

if "x%~1"=="x" call :OSInit
call :UserLogon "%~1"
call :PreShell "%~1"
call :RunShell
call :PostShell

if not "x%USERNAME%"=="xSYSTEM" goto :EOF
echo SYSTEM account inited
cmd.exe

goto :EOF

:OSInit
echo "%~nx0" > "X:\Windows\Temp\SYSTEM_LOADER"
wpeinit.exe
call "X:\PEMaterial\Autoruns\PEStartupMain.bat" OSInit
goto :EOF

:PreShell
if "x%~1"=="x" set USERPROFILE=X:\Users\Default
set Desktop=%USERPROFILE%\Desktop
set "Programs=%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"

if exist %SystemRoot%\System32\IME_Cmd.cmd (
    call %SystemRoot%\System32\IME_Cmd.cmd
)

call "X:\PEMaterial\Autoruns\PEStartupMain.bat" BeforeShell
goto :EOF

:RunShell
if exist "%windir%\explorer.exe" (
    if "x%USERNAME%"=="xSYSTEM" start explorer.exe
    if exist "%ProgramFiles%\WinXShell\WinXShell.exe" (
        start "wxsDaemon" "%ProgramFiles%\WinXShell\WinXShell.exe" -regist -daemon
    )
) else (
    if exist "%ProgramFiles%\WinXShell\WinXShell.exe" (
        if "x%USERNAME%"=="xSYSTEM" (
            start "WinXShell" "%ProgramFiles%\WinXShell\WinXShell.exe" -regist -winpe
        )
    )
)
goto :EOF

:PostShell
if "x%USERNAME%"=="xSYSTEM" echo SYSTEM > "X:\Windows\Temp\SYSTEM_UserInited"
call "X:\PEMaterial\Autoruns\PEStartupMain.bat" PostShell
goto :EOF

:UserLogon
if "x%~1"=="x-init" goto :EOF
if not exist "%WinDir%\System32\LogonAdmin.bat" goto :EOF
if not exist "%ProgramFiles%\WinXShell\WinXShell.exe" goto :EOF

if "x%~1"=="x-user" goto :END_UI_LOGON

rem 1 - SYSTEM, 2 - ADMIN
start "wxsUI_Logon" /wait "%ProgramFiles%\WinXShell\WinXShell.exe" -ui -jcfg "X:\PEMaterial\UI_LogonPE.jcfg"
echo set Logon_User=ADMIN
if not "x%errorlevel%"=="x2" (
  echo set Logon_User=SYSTEM
  goto :EOF
)

:END_UI_LOGON
call LogonAdmin.bat
echo rem Waiting until ADMIN => SYSTEM
if exist "X:\Windows\Temp\SYSTEM_UserInited" goto :EOF
echo rem Waiting until ADMIN => SYSTEM
start "WaitForSession_SYSTEM" /wait "%ProgramFiles%\WinXShell\WinXShell.exe" -luacode WaitForSession('SYSTEM')
echo rem Detect ADMIN => SYSTEM session changing, init for SYSTEM account
