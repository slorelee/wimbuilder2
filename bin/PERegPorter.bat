echo off
set GetLastError=1

rem %%1 must be "Src" or "Tmp"
if "x%1"=="x" goto :EOF
if /i "x%1"=="xSrc" goto :MAIN
if /i "x%1"=="xTmp"  goto :MAIN

:MAIN
if /i "x%2"=="xLOAD" goto :REG_PORTER
if /i "x%2"=="xUNLOAD" (
  set "COMMENT_STR=) ^& rem ("
  goto :REG_PORTER
)

goto :EOF

:REG_PORTER
set GetLastError=0
set "FILEPATH=%X%\Windows\System32\config"
set "FILEPATH_NTUSER=%X%\Users\Default"

if /i "x%1"=="xSrc" (
  if "x%WB_SRC_DIR%"=="x" goto :EOF
  set "FILEPATH=%WB_SRC_DIR%\Windows\System32\config"
  set "FILEPATH_NTUSER=%WB_SRC_DIR%\Users\Default"
)

rem check existence before UNLOAD
rem   Query -* HKEY_USERS\.DEFAULT\Environment
rem   Query -* HKEY_LOCAL_MACHINE\SAM\SAM
rem   Query -* HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft
rem   Query -* HKEY_LOCAL_MACHINE\SYSTEM\Software
rem   Query -* HKEY_CURRENT_USER\Environment

rem forget above, because already loaded to HKLM, so just Query HKLM\Src_DEFAULT,HKLM\Src_Software,...

if /i "x%2"=="xUNLOAD" (
  reg query HKLM\%1_DEFAULT /ve 2>nul 1>&2
  if ERRORLEVEL 1 goto :DEAL_SAM
)
(REG %2 HKLM\%1_DEFAULT %COMMENT_STR% "%FILEPATH%\DEFAULT")
if ERRORLEVEL 1 set GetLastError=1

:DEAL_SAM
if /i "x%2"=="xUNLOAD" (
  reg query HKLM\%1_SAM /ve 2>nul 1>&2
  if ERRORLEVEL 1 goto :DEAL_SECURITY
)
if "x%WB_REG_USE_SAM%"=="x1" (
  REG %2 HKLM\%1_SAM %COMMENT_STR% "%FILEPATH%\SAM")
  if ERRORLEVEL 1 set GetLastError=1
)

:DEAL_SECURITY
if /i "x%2"=="xUNLOAD" (
  reg query HKLM\%1_SECURITY /ve 2>nul 1>&2
  if ERRORLEVEL 1 goto :DEAL_SOFTWARE
)
if "x%WB_REG_USE_SECURITY%"=="x1" (
  (REG %2 HKLM\%1_SECURITY %COMMENT_STR% "%FILEPATH%\SECURITY")
  if ERRORLEVEL 1 set GetLastError=1
)

:DEAL_SOFTWARE
if /i "x%2"=="xUNLOAD" (
  reg query HKLM\%1_SOFTWARE /ve 2>nul 1>&2
  if ERRORLEVEL 1 goto :DEAL_SYSTEM
)
(REG %2 HKLM\%1_SOFTWARE %COMMENT_STR% "%FILEPATH%\SOFTWARE")
if ERRORLEVEL 1 set GetLastError=1

:DEAL_SYSTEM
if /i "x%2"=="xUNLOAD" (
  reg query HKLM\%1_SYSTEM /ve 2>nul 1>&2
  if ERRORLEVEL 1 goto :DEAL_DRIVERS
)
(REG %2 HKLM\%1_SYSTEM %COMMENT_STR% "%FILEPATH%\SYSTEM")
if ERRORLEVEL 1 set GetLastError=1

:DEAL_DRIVERS
if /i "x%2"=="xUNLOAD" (
  reg query HKLM\%1_DRIVERS /ve 2>nul 1>&2
  if ERRORLEVEL 1 goto :DEAL_NTUSER
)
(REG %2 HKLM\%1_DRIVERS %COMMENT_STR% "%FILEPATH%\DRIVERS")
if ERRORLEVEL 1 set GetLastError=1

:DEAL_NTUSER
if /i "x%2"=="xUNLOAD" (
  reg query HKLM\%1_NTUSER.DAT /ve 2>nul 1>&2
  if ERRORLEVEL 1 goto :DEAL_END
)
(REG %2 HKLM\%1_NTUSER.DAT %COMMENT_STR% "%FILEPATH_NTUSER%\NTUSER.DAT")
if ERRORLEVEL 1 set GetLastError=1

:DEAL_END
set FILEPATH=
set FILEPATH_NTUSER=
set COMMENT_STR=

