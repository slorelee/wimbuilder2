set GetLastError=1
set _REWRITE_MODE=

rem %%1 must be "Src" or "Tmp"
if "x%1"=="x" goto :EOF
if /i "x%1"=="xSrc" goto :MAIN
if /i "x%1"=="xTmp"  goto :MAIN

:MAIN
if /i "x%2"=="xLOAD" call :REG_PORTER %1 %2
if /i "x%2"=="xUNLOAD" (
  set "COMMENT_STR=) ^& rem ("
  call :REG_PORTER %1 %2
)
if /i "x%2"=="xREWRITE" (
  set "COMMENT_STR=) ^& rem ("
  set _REWRITE_MODE=1
  call :REG_PORTER %1 UNLOAD
)

goto :EOF

:REG_PORTER
set GetLastError=0
set "FILEPATH=%X%\Windows\System32\config"
set "FILEPATH_NTUSER=%X%\Users\Default"

rem can't read WB_SRC_PATH from cleanup button,
rem but UNLOAD don't use the FILEPATH, so skip the check.
if /i "x%2"=="xUNLOAD" goto :PATH_FIX_END

if /i "x%1"=="xSrc" (
  if "x%WB_SRC_PATH%"=="x" goto :EOF
  set "FILEPATH=%WB_SRC_PATH%\Windows\System32\config"
  set "FILEPATH_NTUSER=%WB_SRC_PATH%\Users\Default"
)
:PATH_FIX_END

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
if  "%1x%_REWRITE_MODE%"=="Tmpx1" reg save HKLM\Tmp_Software "%X_SYS%\config\SOFTWARE.hiv" /y /c
(REG %2 HKLM\%1_SOFTWARE %COMMENT_STR% "%FILEPATH%\SOFTWARE")
if  "%1x%_REWRITE_MODE%"=="Tmpx1" (
    del /f /q /a "%X_SYS%\config\SOFTWARE"
    ren "%X_SYS%\config\SOFTWARE.hiv" SOFTWARE
)
if ERRORLEVEL 1 set GetLastError=1

:DEAL_SYSTEM
if /i "x%2"=="xUNLOAD" (
  reg query HKLM\%1_SYSTEM /ve 2>nul 1>&2
  if ERRORLEVEL 1 goto :DEAL_DRIVERS
)
if  "%1x%_REWRITE_MODE%"=="Tmpx1" reg save HKLM\Tmp_SYSTEM "%X_SYS%\config\SYSTEM.hiv" /y /c
(REG %2 HKLM\%1_SYSTEM %COMMENT_STR% "%FILEPATH%\SYSTEM")
if  "%1x%_REWRITE_MODE%"=="Tmpx1" (
    del /f /q /a "%X_SYS%\config\SYSTEM"
    ren "%X_SYS%\config\SYSTEM.hiv" SYSTEM
)
if ERRORLEVEL 1 set GetLastError=1

:DEAL_DRIVERS
if /i "x%2"=="xUNLOAD" (
  reg query HKLM\%1_DRIVERS /ve 2>nul 1>&2
  if ERRORLEVEL 1 goto :DEAL_NTUSER
)
if  "%1x%_REWRITE_MODE%"=="Tmpx1" reg save HKLM\Tmp_DRIVERS "%X_SYS%\config\DRIVERS.hiv" /y /c
(REG %2 HKLM\%1_DRIVERS %COMMENT_STR% "%FILEPATH%\DRIVERS")
if  "%1x%_REWRITE_MODE%"=="Tmpx1" (
    del /f /q /a "%X_SYS%\config\DRIVERS"
    ren "%X_SYS%\config\DRIVERS.hiv" DRIVERS
)
if ERRORLEVEL 1 set GetLastError=1

:DEAL_NTUSER
if /i "x%2"=="xUNLOAD" (
  reg query HKLM\%1_NTUSER.DAT /ve 2>nul 1>&2
  if ERRORLEVEL 1 goto :DEAL_END
)
(REG %2 HKLM\%1_NTUSER.DAT %COMMENT_STR% "%FILEPATH_NTUSER%\NTUSER.DAT")
if ERRORLEVEL 1 set GetLastError=1

:DEAL_END
set _REWRITE_MODE=
set FILEPATH=
set FILEPATH_NTUSER=
set COMMENT_STR=

