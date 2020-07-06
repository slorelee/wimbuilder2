set APP_NAME=Explorer++
call App pull https://explorerplusplus.com/software/explorer++_1.3.5_x%_V8664%.zip
call :BUILD

set APP_FILE=
if "%WB_PE_LANG%"=="zh-CN" (
    call App pull https://explorerplusplus.com/software/translations/explorer++_1.3.5_ZH.zip
    call :LANG 4 
)
goto :EOF

:BUILD
call V2X "%APP_CACHE%" -extract "%APP_FILE%" "%X_PF%\%APP_NAME%\"
del /f /q /a "%X_PF%\%APP_NAME%\*.txt"
goto :EOF

:LANG
call V2X "%APP_CACHE%" -extract "%APP_FILE%" "%X_PF%\%APP_NAME%\"
reg add "HKLM\Tmp_SOFTWARE\Explorer++\Settings" /v Language /t REG_DWORD /d %1 /f
goto :EOF
