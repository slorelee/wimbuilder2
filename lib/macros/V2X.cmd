echo [MACRO]V2X.cmd %*
rem      V2X.cmd -init
rem      V2X.cmd name [-extract|-copy|-xcopy|version] ...

rem for /f "delims==" %%i in ('set _V_') do set %%i=

if "x%_V_Arch%"=="x" call :INIT_VARCHS
if /i "x%~1"=="x-init" goto :EOF

set "_V_Name=%~1"
set _V_Ver=*
set _V_File=

if "x%~2"=="x" set _V_Ver=*

if not "x%_V_Name%"=="x" (
    pushd "%V%\%_V_Name%"
) else (
  pushd "%V%"
)

if /i "x%~2"=="x-extract" call :ACT_EXTRACT "%~3" "%~4" && goto :ACT_END
if /i "x%~2"=="x-copy" call :ACT_COPY "%~3" "%~4" "%~5" && goto :ACT_END
if /i "x%~2"=="x-xcopy" call :ACT_XCOPY "%~3" "%~4" "%~5" && goto :ACT_END

:ACT_END

if not "x%_V_Name%"=="x" (
    if exist main.bat call "%V%\%_V_Name%\main.bat" %*
)

popd
goto :EOF

:INIT_VARCHS
set _V_Arch=%WB_PE_ARCH%
set _V64=
set _Vx64=
set _V-x64=
set _V_x64=

if "%_V_Arch%"=="x64" (
    set _V64=64
    set _Vx64=x64
    set _V-x64=-x64
    set _V_x64=_x64
)
goto :EOF

:ACT_EXTRACT
call VGetFile "%~1"
call Extract2X "%_V_File%" "%~2"
goto :EOF

:ACT_COPY
copy %~3 "%~1" "%~2"
goto :EOF

:ACT_XCOPY
xcopy %~3 "%~1" "%~2"
goto :EOF


