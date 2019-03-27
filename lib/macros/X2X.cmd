set "X2X_EXCLUDE=%~dps0X2X_EXCLUDE.txt"
set _X2X_PUSHED=0

if not "x%~1"=="x" (
    if exist "%~1\" (
        set _X2X_PUSHED=1
        pushd "%~1"
    )
)

if exist X\ (
    xcopy /E /Y X\*.* "%X%\" /EXCLUDE:%X2X_EXCLUDE%
    pushd X
    call :X_SERIES_COPY
    popd
)

rem X_x64, X_x86
if exist X_%WB_PE_ARCH%\ (
    xcopy /E /Y X_%WB_PE_ARCH%\*.* "%X%\" /EXCLUDE:%X2X_EXCLUDE%
    pushd X_%WB_PE_ARCH%
    call :X_SERIES_COPY
    popd
)

call :X_SERIES_COPY

if %_X2X_PUSHED% EQU 1 popd
set _X2X_PUSHED=
goto :EOF

:X_SERIES_COPY
if exist X_PF\ (
    xcopy /E /Y X_PF\*.* "%X%\Program Files\"
)

if exist "X_PF(x86)\" (
    xcopy /E /Y "X_PF(x86)\*.*" "%X%\Program Files(x86)\"
)

if exist X_WIN\ (
    xcopy /E /Y X_WIN\*.* "%X%\Windows\"
)

if exist X_SYS\ (
    xcopy /E /Y X_SYS\*.* "%X_SYS%\"
)

rem alias of X_SYS
if exist X_SYS32\ (
    xcopy /E /Y X_SYS32\*.* "%X_SYS%\"
)

if exist X_Desktop\ (
    xcopy /E /Y X_Desktop\*.* "%X%\Users\Default\Desktop\"
)

rem X_WOW, X_WOW64
rem X.wim(x64,x86)
goto :EOF
