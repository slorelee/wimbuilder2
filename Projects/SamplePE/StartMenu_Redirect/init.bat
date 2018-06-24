@echo off
echo %cd%

call OpenTextFile CUSTOM_MACRO %Target_Sys%\autorun.cmd %0 :end_autorun
goto :end_autorun
MoveTo "exit", -1
Add "This is a line before exit"
Add :RAW
IF EXIST Y:\System\Registry\*.REG (
  FOR %%R IN (Y:\System\Registry\*.REG) DO REGEDIT /S "%%R" >nul
) ELSE (
  IF NOT EXIST Y:\System\Registry MD Y:\System\Registry >nul
  XCOPY %SystemRoot%\Docs\Reg\*.* Y:\System\ /S /Q /Y /K >nul
)
:END_RAW

:end_autorun

copy %cd%\autorun.cmd %cd%\autorun.js.cmd
call OpenTextFile JS %cd%\autorun.js.cmd %0 :end_autorun_js
goto :end_autorun_js
txt = txt.replace('exit', '\
IF EXIST Y:\\System\\Registry\\*.REG (\r\n\
  FOR %%R IN (Y:\\System\\Registry\\*.REG) DO REGEDIT /S "%%R" >nul\r\n\
) ELSE (\r\n\
  IF NOT EXIST Y:\\System\\Registry MD Y:\\System\\Registry >nul\r\n\
  XCOPY %SystemRoot%\\Docs\\Reg\\*.* Y:\\System\\ /S /Q /Y /K >nul\r\n\
)\r\n\
exit');
:end_autorun_js

pause
exit
