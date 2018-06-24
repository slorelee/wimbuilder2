set USERPROFILE=X:\Users\Default
wpeinit

explorer.exe
rem the line after explorer.exe

IF EXIST Y:\System\Registry\*.REG (
  FOR %%R IN (Y:\System\Registry\*.REG) DO REGEDIT /S "%%R" >nul
) ELSE (
  IF NOT EXIST Y:\System\Registry MD Y:\System\Registry >nul
  XCOPY %SystemRoot%\Docs\Reg\*.* Y:\System\ /S /Q /Y /K >nul
)
exit
rem this is the last line
rem =====================