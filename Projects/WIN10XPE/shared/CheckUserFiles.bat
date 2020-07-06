echo Check User Custom Files ...
call :ChkUserFile "%_USER_CUSTOMFILES_%\ProductOptions.txt"
call :ChkUserFile "%_USER_CUSTOMFILES_%\IE_Settings.bat"
echo.
call :ChkUserFile "%_USER_CUSTOMFILES_%\_Prepare_.bat"
call :ChkUserFile "%_USER_CUSTOMFILES_%\MyCustom\"
call :ChkUserFile "%_USER_CUSTOMFILES_%\final.bat"
call :ChkUserFile "%_USER_CUSTOMFILES_%\_CustomISO_.bat"
echo.
echo.
goto :EOF


:ChkUserFile
if exist "%~1" (
    echo [Found] - %1
) else (
    echo [     ] - %1
)
goto :EOF