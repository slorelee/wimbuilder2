set "args=%*"
if "x%args:~0,7%"=="xNO_KEY " goto :NO_KEY_REG
if "x%args:~0,7%"=="xNO_VAL " goto :NO_VAL_REG
echo [MACRO]RegEx Error:Invaild paramters(%*).
goto :EOF

:NO_KEY_REG
reg query "%~3" 1>nul 2>nul
if ERRORLEVEL 1 reg %args:~7%
goto :EOF

:NO_VAL_REG
reg query "%~3" /v "%~5" 1>nul 2>nul
if ERRORLEVEL 1 reg %args:~7%
goto :EOF
