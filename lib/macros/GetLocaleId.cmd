echo [MACRO]GetLocaleId %*
for /f "delims=" %%i in ('cscript.exe //nologo "%I18N_SCRIPT%" GetLocaleIdByName %1') do set GetLocaleId_Ret=%%i
