@reg query HKEY_USERS\S-1-5-20 1>nul 2>nul
if ERRORLEVEL 1 exit /B 0
exit /B 1
