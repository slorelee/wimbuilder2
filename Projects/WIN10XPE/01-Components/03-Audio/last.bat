rem fix unrecognized characters in volume mixer dialog
rem // reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink" /v "Microsoft YaHei UI"
if not exist "%X_WIN%\Fonts\Malgun.ttf" (
    if "%WB_PE_LANG%"=="zh-CN" copy /y Malgun.ttf "%X_WIN%\Fonts\"
)
