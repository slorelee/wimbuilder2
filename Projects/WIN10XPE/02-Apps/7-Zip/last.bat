
if "%WB_PE_LANG%"=="zh-CN" set _7z_lang=zh-cn
if "%WB_PE_LANG%"=="fr-FR" set _7z_lang=fr

if not "x%_7z_lang%"=="x" (
  ren "%X%\Program Files\7-Zip\Lang\%_7z_lang%.txt" %_7z_lang%.ttt
  del "%X%\Program Files\7-Zip\Lang\*.txt"
  ren "%X%\Program Files\7-Zip\Lang\%_7z_lang%.ttt" %_7z_lang%.txt
)
set _7z_lang=

call TextReplace "%X_SYS%\pecmd.ini" "_SUB Shortcuts" "_SUB Shortcuts#r#nLINK #pDesktop#p\7-zip,#pProgramFiles#p\7-zip\7zFM.exe"
call TextReplace "%X_SYS%\pecmd.ini" "_SUB LoadShell" "_SUB LoadShell#r#nEXEC =reg import #qX:\Program Files\7-Zip\7z-Register.reg#q"

