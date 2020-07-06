call :Apply_MyCutom MyCustom\Last
call :Apply_MyCutom "%_USER_CUSTOMFILES_%\MyCustom\Last"
goto :EOF

:Apply_MyCutom
if not exist "%~1" goto :EOF

for /f "usebackq" %%i in (`dir /b "%~1\*.bat"`) do (
  echo Applying %~1\%%i ...
  call "%~1\%%i"
)
goto :EOF
