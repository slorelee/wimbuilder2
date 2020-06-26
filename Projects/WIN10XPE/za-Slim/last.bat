if "x%opt[system.workgroup]%"=="x" (
    rem del /a /f /q "%X_SYS%\startnet.exe"
)

call :SUB_SLIM SlimResources
call :SUB_SLIM SlimRegistry
goto :EOF

:SUB_SLIM
if not exist "%~1" goto :EOF
pushd "%~1"
call last.bat
popd
goto :EOF
