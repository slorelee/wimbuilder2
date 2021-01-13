echo [MACRO]LuaLink %*
if "x%~1"=="x-init" goto :LINK_INIT
if "x%~1"=="x-done" goto :LINK_DONE
if "x%LUALINK_FILE%"=="x" echo MISS LUALINK_FILE && goto :EOF

if /i "x%~1"=="x-paramlist" goto :LINK_PARAMLIST
if /i "x%~1"=="x-pl" goto :LINK_PARAMLIST
(echo LINK^([[%~1]], [[%~2]]^)) >> "%LUALINK_FILE%"
goto :EOF

:LINK_PARAMLIST
(echo LINK^(%~2^)) >> "%LUALINK_FILE%"
goto :EOF

:LINK_INIT
set "LUALINK_FILE=%~2"
goto :EOF

:LINK_DONE
if "x%LUALINK_FILE%"=="x" goto :EOF
if not exist "%LUALINK_FILE%" goto :EOF
call TextReplace "%LUALINK_FILE%" #{# "(" g
call TextReplace "%LUALINK_FILE%" #}# ")" g
call TextReplace "%LUALINK_FILE%" #sp "%%%%" g
call TextReplace "%LUALINK_FILE%" #sq #q g
goto :EOF
