echo [MACRO]LinkToDesktop %*

if /i "x%~1"=="x-paramlist" goto :LINK_PARAMLIST
if /i "x%~1"=="x-pl" goto :LINK_PARAMLIST
call LuaLink "%%%%Desktop%%%%\%~1" "%~2"
goto :EOF

:LINK_PARAMLIST
call LuaLink -paramlist "[[%%%%Desktop%%%%\%~2]], %~3"
goto :EOF
