call :Apply_MyCutom
goto :EOF

:Apply_MyCutom
if not exist MyCustom\Last goto :EOF

for /f %%i in ('dir /b MyCustom\Last\*.bat') do (
  echo Applying MyCustom\Last\%%i ...
  call MyCustom\Last\%%i
)
goto :EOF
