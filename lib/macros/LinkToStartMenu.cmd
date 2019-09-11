echo [MACRO]LinkToStartMenu %*

if /i "x%~1"=="x-paramlist" goto :LINK_PARAMLIST
if /i "x%~1"=="x-pl" goto :LINK_PARAMLIST
call LuaLink "%%%%Programs%%%%\%~1" "%~2"
goto :EOF

:LINK_PARAMLIST
call LuaLink -paramlist "[[%%%%Programs%%%%\%~2]], %~3"
goto :EOF
