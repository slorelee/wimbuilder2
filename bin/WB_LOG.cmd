if "x%I18N_SCRIPT%"=="x" goto :EOF
call :i18n.t LOG %*
echo %i18n.str%
if "x%LOGFILE%"=="x" goto :EOF
>>%LOGFILE% (echo %i18n.log%)

goto :EOF

rem =========================================================
:i18n.t
if not "x%DEBUG_MODE%"=="x" echo %*
set i18n.str=
set i18n.log=
if "%I18N_LCID%"=="0" (
  if /i "x%~1"=="xECHO" (
    if "x%~3"=="x" (
      set i18n.str=%~2
      goto :EOF
    )
  )
)

set tmp_i=1
for /f "delims=" %%s in ('cscript.exe //nologo "%I18N_SCRIPT%" %*') do (
  set i18n.str!tmp_i!=%%s
  set /a tmp_i+=1
)
set tmp_i=
set i18n.str=%i18n.str1%
set i18n.log=%i18n.str2%
goto :EOF


