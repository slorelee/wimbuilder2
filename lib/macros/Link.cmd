rem //TODO more parameters

echo [MACRO]LINK %*
if "x%PE_LOADER%"=="xPECMD" call :PECMD_LINK %*
if "x%PE_LOADER%"=="xLUA" call :LUA_LINK %*
goto :EOF

:PECMD_LINK
call TextReplace "%X_SYS%\pecmd.ini" "_SUB Shortcuts" "_SUB Shortcuts#r#nLINK %~1,%~2"
goto :EOF

:LUA_LINK
call TextReplace "%X_PEMaterial%\pecmd.lua" "local function CustomShortcuts()" "local function CustomShortcuts()#r#n  LINK([[%~1.lnk]], [[%~2]])"
goto :EOF
