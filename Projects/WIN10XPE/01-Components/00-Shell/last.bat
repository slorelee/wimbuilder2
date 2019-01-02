rem show This PC on Desktop
if not "x%opt[shell.show_thisPC]%"=="xfalse" (
    reg add "HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 0 /f
) else (
    reg add "HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 1 /f
)

rem Wallpaper
if "x%opt[shell.wallpaper]%"=="x" goto :EOF
copy /y "%opt[shell.wallpaper]%" "%X_SYS%\winre.jpg"
copy /y "%opt[shell.wallpaper]%" "%X_SYS%\winpe.jpg"
if not exist "%X%\Windows\Web\Wallpaper\Windows\" mkdir "%X%\Windows\Web\Wallpaper\Windows"
copy /y "%opt[shell.wallpaper]%" "%X%\Windows\Web\Wallpaper\Windows\img0.jpg"

rem reg add "HKLM\Tmp_Default\Control Panel\Desktop" /v Wallpaper /d X:\Windows\Web\Wallpaper\Windows\img0.jpg /f
rem reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\Desktop\General" /v WallpaperSource /d X:\Windows\Web\Wallpaper\Windows\img0.jpg /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\WinPE" /v CustomBackground /t REG_EXPAND_SZ /d X:\Windows\Web\Wallpaper\Windows\img0.jpg /f

