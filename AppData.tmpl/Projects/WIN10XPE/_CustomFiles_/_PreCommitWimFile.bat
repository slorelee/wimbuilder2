rem echo the final process before commiting the boot.wim

rem use prepared HIVE files

call :FULLREG DEFAULT
call :FULLREG SOFTWARE
call :FULLREG SYSTEM
call :FULLREG COMPONENTS
call :FULLREG DRIVERS

goto :EOF

:FULLREG
if exist "%~dp0%1" (
   xcopy /E /Y "%~dp0%1" "%X%\Windows\System32\Config\"
)
goto :EOF


