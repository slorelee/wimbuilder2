call V2X 7-Zip -Extract "7z*-%_V_ARCH%.exe" "%X_PF%\7-Zip\"
copy /y 7z-Register.reg "%X_PF%\7-Zip\"

call :REMOVE_LANGFILES

call Link "#pDesktop#p\7-zip" "#pProgramFiles#p\7-zip\7zFM.exe"
call RunBeforeShell "reg import #qX:\Program Files\7-Zip\7z-Register.reg#q"
rem call Shortcuts "StartMenu,Desktop,PintTaskbar,PinStartMenu"
goto :EOF

:REMOVE_LANGFILES
if "%WB_PE_LANG%"=="fr-FR" set _7z_lang=fr
if "%WB_PE_LANG%"=="ja-JP" set _7z_lang=ja
if "%WB_PE_LANG%"=="ko-KR" set _7z_lang=ko
if "%WB_PE_LANG%"=="zh-CN" set _7z_lang=zh-cn
if "%WB_PE_LANG%"=="zh-TW" set _7z_lang=zh-tw

if not "x%_7z_lang%"=="x" (
  ren "%X%\Program Files\7-Zip\Lang\%_7z_lang%.txt" %_7z_lang%.ttt
  del "%X%\Program Files\7-Zip\Lang\*.txt"
  ren "%X%\Program Files\7-Zip\Lang\%_7z_lang%.ttt" %_7z_lang%.txt
)
set _7z_lang=
