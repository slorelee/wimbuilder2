abc
test
def
IF EXIST Y:\SystemRegistry\*.REG (
  FOR %%R IN (Y:\System\Registry\*.REG) DO REGEDIT /S "%%R" >nul
) ELSE (
  IF NOT EXIST Y:\System\Registry MD Y:\System\Registry >nul
  XCOPY %SystemRoot%\Docs\Reg\*.* Y:\System\ /S /Q /Y /K >nul
)
exit
