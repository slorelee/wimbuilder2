@echo off

set _VxARCH=x64
if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
    set _VxARCH=x86
)
set SysWOW64=SysWOW64
if "x%_ARCH%"=="xx86" set SysWOW64=System32

set _V8664=86
set _V3264=32
if "%_VxARCH%"=="x64" (
    set _V8664=64
    set _V3264=64
    set _V64=64
    set _V-64=-64
    set _V_64=_64
    set _Vx64=x64
    set _V-x64=-x64
    set _V_x64=_x64
)

set Startup_Phase=%1
if "x%Startup_Phase%"=="x" (
    set Startup_Phase=BeforeShell
) else if "x%Startup_Phase%"=="xOSInit" (
    "X:\Program Files\WinXShell\WinXShell.exe" -regist -noaction
    call "%~dp0\Runner.bat" OSInit
    goto :EOF
) else if "x%Startup_Phase%"=="xBeforeShell" (
    call "%~dp0\Runner.bat" Startup\BeforeShell
) else if "x%Startup_Phase%"=="xPostShell" (
    call "%~dp0\Runner.bat" Startup
)

rem PEStartup flag
if not "x%1"=="x" (
    if exist "%~dp0PEStartup.Disabled" goto :EOF
)

:PEStartup_BeforeShell
:PEStartup_PostShell
if exist "%Temp%\Phase_%Startup_Phase%" goto :PEStartup_BeforeShell_Done
call :PEStartup X,Z,Y,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A
if "x%Startup_Phase%"=="xBeforeShell" echo done>"%Temp%\Phase_%Startup_Phase%"
:PEStartup_BeforeShell_Done
if not "x%1"=="x" goto :EOF

set Startup_Phase=PostShell
call :PEStartup_PostShell BYE
goto :EOF

:PEStartup
if "%1"=="" goto :EOF
if exist "%1:\PEMaterial\PEStartup.bat" (
    call "%1:\PEMaterial\PEStartup.bat" %Startup_Phase%
)
SHIFT
goto :PEStartup
