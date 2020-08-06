if exist "%X_PF%\7-Zip\7z.exe" goto :EOF

call V2X 7-Zip -Extract "7z*-%_Vx8664%.exe" "%X_PF%\7-Zip\"
copy /y 7z-Register.reg "%X_Startup%\BeforeShell\"

reg add "HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\7z.exe" /ve /d "X:\Program Files\7-Zip\7z.exe" /f
reg add "HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\7z.exe" /v Path /d "X:\Program Files\7-Zip" /f

call AssocExt.bat
call :REMOVE_LANGFILES

call LinkToDesktop "7-Zip.lnk" "#pProgramFiles#p\7-Zip\7zFM.exe"
call LinkToStartMenu "7-Zip\7-Zip File Manager.lnk" "#pProgramFiles#p\7-Zip\7zFM.exe"
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
