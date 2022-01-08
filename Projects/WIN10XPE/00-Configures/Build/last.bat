if not "x%opt[build.registry.system]%"=="xmerge" goto :EOF

rem useless drivers
call :REMOVE_SERV_REG iorate drivers\iorate.sys
call :REMOVE_SERV_REG rdyboost drivers\rdyboost.sys
call :REMOVE_SERV_REG WindowsTrustedRT drivers\WindowsTrustedRT.sys

rem BSOD
call :REMOVE_SERV_REG FileCrypt drivers\filecrypt.sys

rem desktop
call :REMOVE_SERV_REG StateRepository dummy.dll
call :REMOVE_SERV_REG TokenBroker tokenbroker.dll

rem mouse
call :REMOVE_SERV_REG BrokerInfrastructure bisrv.dll

goto :EOF

:REMOVE_SERV_REG
if not exist "%X_SYS%\%~2" reg delete "HKLM\Tmp_SYSTEM\ControlSet001\Services\%~1" /f
goto :EOF
