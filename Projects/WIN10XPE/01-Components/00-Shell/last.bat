rem Apply Theme Color for Taskbar
if "x%opt[shell.use_theme_color]%"=="xfalse" (
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v ColorPrevalence /t REG_DWORD /d 0 /f
) else (
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v ColorPrevalence /t REG_DWORD /d 1 /f
)

rem Windows(Taskbar) Light Theme
if "x%opt[shell.light_theme]%"=="xtrue" (
    rem check WB_PE_VER GEQ 18362
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 1 /f
) else (
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
)

rem show This PC on Desktop
if not "x%opt[shell.show_thisPC]%"=="xfalse" (
    reg add "HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 0 /f
) else (
    reg add "HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 1 /f
)

rem show Recycle Bin on Desktop
if not "x%opt[shell.show_recyclebin]%"=="xfalse" (
    reg add "HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {645FF040-5081-101B-9F08-00AA002F954E} /t REG_DWORD /d 0 /f
) else (
    reg add "HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {645FF040-5081-101B-9F08-00AA002F954E} /t REG_DWORD /d 1 /f
)

if not "x%opt[desktop.iconsize]%"=="x" (
    reg add "HKLM\Tmp_Default\Software\Microsoft\Windows\Shell\Bags\1\Desktop" /v IconSize /t REG_DWORD /d %opt[desktop.iconsize]% /f
)

rem remove folders in My Computer View
set _MyComView=HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace

rem remove "downloads"
reg delete %_MyComView%\{088e3905-0323-4b02-9826-5d99428e115f} /f
rem remove "Pictures"
reg delete %_MyComView%\{24ad3ad4-a569-4530-98e1-ab02f9417aa8} /f
rem remove "Music"
reg delete %_MyComView%\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de} /f
rem remove "Videos"
reg delete %_MyComView%\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a} /f
rem remove "3D Objects"
reg delete %_MyComView%\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A} /f

rem remove "MyDocuments"
reg delete %_MyComView%\{d3162b92-9365-467a-956b-92703aca08af} /f
rem remove "Desktop"
rem reg delete %_MyComView%\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641} /f

set _MyComView=

rem Wallpaper
if "x%opt[shell.wallpaper]%"=="x" goto :END_WALLPAPER
copy /y "%opt[shell.wallpaper]%" "%X_SYS%\winre.jpg"
copy /y "%opt[shell.wallpaper]%" "%X_SYS%\winpe.jpg"
if not exist "%X%\Windows\Web\Wallpaper\Windows\" mkdir "%X%\Windows\Web\Wallpaper\Windows"
copy /y "%opt[shell.wallpaper]%" "%X%\Windows\Web\Wallpaper\Windows\img0.jpg"

reg add "HKLM\Tmp_Default\Control Panel\Desktop" /v Wallpaper /d X:\Windows\Web\Wallpaper\Windows\img0.jpg /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\Desktop\General" /v WallpaperSource /d X:\Windows\Web\Wallpaper\Windows\img0.jpg /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\WinPE" /v CustomBackground /t REG_EXPAND_SZ /d X:\Windows\Web\Wallpaper\Windows\img0.jpg /f
:END_WALLPAPER

rem // 0=Always combine, hide labels, 1=Combine when taskbar is full,2=Never combine
set TaskbarCombineType=2
if "x%opt[shell.taskbar.combine]%"=="xalways" (
    set TaskbarCombineType=0
) else if "x%opt[shell.taskbar.combine]%"=="xauto" (
    set TaskbarCombineType=1
)
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v TaskbarGlomLevel /t REG_DWORD /d %TaskbarCombineType% /f
set TaskbarCombineType=

rem Display, Personalize
if not exist "%X_SYS%\ieframe.dll" (
    reg add HKLM\Tmp_Software\Classes\DesktopBackground\Shell\Display\command /d "WinXShell.exe ms-settings:display" /f
    reg delete HKLM\Tmp_Software\Classes\DesktopBackground\Shell\Display\command /v DelegateExecute /f
    reg add HKLM\Tmp_Software\Classes\DesktopBackground\Shell\Personalize\command /d "WinXShell.exe ms-settings:personalization-background" /f
    reg delete HKLM\Tmp_Software\Classes\DesktopBackground\Shell\Personalize\command /v DelegateExecute /f
)

call WinXShell\sublast.bat
