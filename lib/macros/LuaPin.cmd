echo [MACRO]LuaPin %*
if "x%~1"=="x-init" goto :PIN_INIT
if "x%~1"=="x-done" goto :PIN_DONE
if "x%LUAPIN_FILE%"=="x" echo MISS LUAPIN_FILE && goto :EOF

if /i "x%~2"=="x-paramlist" goto :PIN_PARAMLIST
if /i "x%~2"=="x-pl" goto :PIN_PARAMLIST
(echo PinTo%~1^([[%~2]]^)) >> "%LUAPIN_FILE%"
goto :EOF

:PIN_PARAMLIST
(echo PinTo%~1^(%~3^)) >> "%LUAPIN_FILE%"
goto :EOF

:PIN_INIT
set "LUAPIN_FILE=%~2"
goto :EOF

:PIN_DONE
if "x%LUAPIN_FILE%"=="x" goto :EOF
call TextReplace "%LUAPIN_FILE%" #sp "%%%%" g
goto :EOF
