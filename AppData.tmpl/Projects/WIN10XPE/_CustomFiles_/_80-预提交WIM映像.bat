echo 可在此脚本中编写代码，在保存boot.wim变动前，对boot.wim进行最后的修改。

rem 替换注册表 HIVE 文件

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
