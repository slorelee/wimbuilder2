goto :main
Title=Themes Color
Type=XPEPlugin
Description=Themes Color
Author=ChriSR
Date=2018.11.03
Version=001
:main
if "x%opt[theme.title_color]%"=="x" goto :EOF
if "x%opt[theme.title_color]%"=="x0" goto :EOF

rem // Auto Color
if "x%opt[theme.title_color]%"=="x1" (
  reg add "HKLM\Tmp_Default\Control Panel\Desktop" /v AutoColorization /t REG_DWORD /d 1 /f
  reg add HKLM\Tmp_Default\Software\Microsoft\Windows\DWM /v ColorPrevalence /t REG_DWORD /d 1 /f
  reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v ColorPrevalence /t REG_DWORD /d 1 /f
  reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v ColorPrevalence /t REG_DWORD /d 1 /f
  goto :EOF
)

rem // Custom Windows Title Bars and Taskbar color section
reg add "HKLM\Tmp_Default\Control Panel\Desktop" /v AutoColorization /t REG_DWORD /d 0 /f
rem //-
Set=SystemProtectedUserDataRegKey=Microsoft\Windows\CurrentVersion\SystemProtectedUserData\S-1-5-21-1391200042-3413667948-2666945708-500\AnyoneRead\Colors
reg add HKLM\Tmp_Software\%SystemProtectedUserDataRegKey% /v StartColor /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Software\%SystemProtectedUserDataRegKey% /v AccentColor /t REG_DWORD /d 0 /f
rem //-
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\DWM /v ColorizationGlassAttribute /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\DWM /v EnableAeroPeek /t REG_DWORD /d 1 /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\DWM /v AccentColor /t REG_DWORD /d 47615 /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\DWM /v ColorPrevalence /t REG_DWORD /d 1 /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\DWM /v ColorizationColorBalance /t REG_DWORD /d 89 /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\DWM /v ColorizationAfterglowBalance /t REG_DWORD /d 10 /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\DWM /v ColorizationBlurBalance /t REG_DWORD /d 1 /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\DWM /v EnableWindowColorization /t REG_DWORD /d 1 /f
rem //-
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v ColorPrevalence /t REG_DWORD /d 1 /f
reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v ColorPrevalence /t REG_DWORD /d 1 /f
rem //-

rem // Win10 color accent palette Col 3, Line 1 Blue(default)
Set AccentColor=0xffd77800
 set Colorization=0xc40078d7
 Set AccentPalette=a6,d8,ff,00,76,b9,ed,00,42,9c,e3,00,00,78,d7,00,00,5a,9e,00,00,42,75,00,00,26,42,00,f7,63,0c,00
Set StartColorMenu=0xff9e5a00
Set AccentColorMenu=0xffd77800

rem // Win10 color accent palette Col 1, Line 1 Yellow
if "%opt[theme.title_color]%"=="2" (
  Set AccentColor=0xff00b9ff
  Set Colorization=0xc4ffb900
  Set AccentPalette=ff,e8,a8,00,ff,e0,8c,00,ff,d3,5c,00,ff,b9,00,00,ba,89,00,00,80,5e,00,00,4d,38,00,00,00,b2,94,00
  Set StartColorMenu=0xff0089ba
  Set AccentColorMenu=0xff00b9ff
)
rem // Win10 color accent palette Col 1, Line 3
if "%opt[theme.title_color]%"=="3" (
  Set AccentColor=0xff0c63f7
  Set Colorization=0xc4f7630c
  Set AccentPalette=fd,86,5f,00,fc,75,51,00,f8,63,42,00,f7,63,0c,00,d0,41,22,00,9c,31,1a,00,79,27,14,00,00,99,bc,00
  Set StartColorMenu=0xff2241d0
  Set AccentColorMenu=0xff0c63f7
)
rem // Win10 color accent palette Col 1, Line 6
if "%opt[theme.title_color]%"=="4" (
  Set AccentColor=0xff5069ef
  Set Colorization=0xc4ef6950
  Set AccentPalette=ff,c9,bf,00,ff,b7,ab,00,fa,94,82,00,ef,69,50,00,9e,44,34,00,66,2c,22,00,33,12,0c,00,74,4d,a9,00
  Set StartColorMenu=0xff34449e
  Set AccentColorMenu=0xff5069ef
)
rem // Win10 color accent palette Col 2, Line 2
if "%opt[theme.title_color]%"=="5" (
  Set AccentColor=0xff2311e8
  Set Colorization=0xc4e81123
  Set AccentPalette=ff,bd,c2,00,ff,99,a1,00,f0,59,65,00,e8,11,23,00,99,00,0d,00,6e,00,09,00,47,00,06,00,69,79,7e,00
  Set StartColorMenu=0xff0d0099
  Set AccentColorMenu=0xff2311e8
)
rem // Win10 color accent palette Col 3, Line 7
if "%opt[theme.title_color]%"=="6" (
  Set AccentColor=0xffc246b1
  Set Colorization=0xc4b146c2
  Set AccentPalette=f6,c0,ff,00,e5,9d,f0,00,cc,7b,d9,00,b1,46,c2,00,7d,31,89,00,51,20,59,00,38,16,3d,00,ff,8c,00,00
  Set StartColorMenu=0xff89317d
  Set AccentColorMenu=0xffc246b1
)
rem // Win10 color accent palette Col 2, Line 8
if "%opt[theme.title_color]%"=="7" (
  Set AccentColor=0xff89009a
  Set Colorization=0xc49a0089
  Set AccentPalette=fd,8d,f1,00,f2,66,e3,00,cb,3d,bb,00,9a,00,89,00,70,00,63,00,50,00,47,00,33,00,2d,00,00,cc,6a,00
  Set StartColorMenu=0xff630070
  Set AccentColorMenu=0xff89009a
)
rem // Win10 color accent palette Col 3, Line 1
if "%opt[theme.title_color]%"=="8" (
  Set AccentColor=0xffd77800
  set Colorization=0xc40078d7
  Set AccentPalette=a6,d8,ff,00,76,b9,ed,00,42,9c,e3,00,00,78,d7,00,00,5a,9e,00,00,42,75,00,00,26,42,00,f7,63,0c,00
  Set StartColorMenu=0xff9e5a00
  Set AccentColorMenu=0xffd77800
)
rem // Win10 color accent palette Col 3, Line 2
if "%opt[theme.title_color]%"=="9" (
  Set AccentColor=0xffb16300
  Set Colorization=0xc40063b1
  Set AccentPalette=86,ca,ff,00,5f,b2,f2,00,1e,91,ea,00,00,63,b1,00,00,42,75,00,00,2d,4f,00,00,20,38,00,00,cc,6a,00
  Set StartColorMenu=0xff754200
  Set AccentColorMenu=0xffb16300
)
rem // Win10 color accent palette Col 4, Line 4
if "%opt[theme.title_color]%"=="10" (
  Set AccentColor=0xff878303
  Set Colorization=0xc4038387
  Set AccentPalette=b3,f4,f5,00,80,d6,d9,00,37,a9,ad,00,03,83,87,00,00,56,59,00,00,39,3b,00,00,26,26,00,ef,69,50,00
  Set StartColorMenu=0xff595600
  Set AccentColorMenu=0xff878303
)
rem // Win10 color accent palette Col 4, Line 7
if "%opt[theme.title_color]%"=="11" (
  Set AccentColor=0xff6acc00
  Set Colorization=0xc400cc6a
  Set AccentPalette=c1,f7,dd,00,a6,f7,d0,00,68,e3,a8,00,00,cc,6a,00,00,87,46,00,00,52,2a,00,00,2b,16,00,e3,00,8c,00
  Set StartColorMenu=0xff468700
  Set AccentColorMenu=0xff6acc00
)
rem // Win10 color accent palette Col 5, Line 8
if "%opt[theme.title_color]%"=="12" (
  Set AccentColor=0xff107c10
  Set Colorization=0xc4107c10
  Set AccentPalette=90,d6,90,00,61,ba,61,00,3d,9c,3d,00,10,7c,10,00,0c,5c,0c,00,09,42,09,00,02,26,02,00,4c,4a,48,00
  Set StartColorMenu=0xff0c5c0c
  Set AccentColorMenu=0xff107c10
)
rem // Win10 color accent palette Col 5, Line 5
if "%opt[theme.title_color]%"=="13" (
  Set AccentColor=0xff737c56
  Set Colorization=0xc4567c73
  Set AccentPalette=a4,e1,d2,00,8b,bf,b2,00,76,a2,97,00,56,7c,73,00,3a,54,4e,00,29,3a,36,00,1c,2b,28,00,c3,00,52,00
  Set StartColorMenu=0xff4e543a
  Set AccentColorMenu=0xff737c56
)
rem // Win10 color accent palette Col 5, Line 2
if "%opt[theme.title_color]%"=="14" (
  Set AccentColor=0xff585a5d
  Set Colorization=0xc45d5a58
  Set AccentPalette=c5,bf,b9,00,a3,9e,9a,00,87,83,80,00,5d,5a,58,00,3e,3c,3b,00,2b,2a,29,00,1f,1e,1d,00,ff,43,43,00
  Set StartColorMenu=0xff3b3c3e
  Set AccentColorMenu=0xff585a5d
)
rem // Win10 color accent palette Col 6, Line 7
if "%opt[theme.title_color]%"=="15" (
  Set AccentColor=0xff457584
  Set Colorization=0xc4847545
  Set AccentPalette=de,c7,7d,00,c3,af,6e,00,a9,97,5f,00,84,75,45,00,63,56,2c,00,4d,42,1f,00,3b,32,17,00,ef,69,50,00
  Set StartColorMenu=0xff2c5663
  Set AccentColorMenu=0xff457584
)
rem //-
set AccentPalette=%AccentPalette:,=%
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\DWM /v AccentColor /t REG_DWORD /d %AccentColor% /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\DWM /v ColorizationColor /t REG_DWORD /d %Colorization% /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\DWM /v ColorizationAfterglow /t REG_DWORD /d %Colorization% /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent /v AccentPalette /t REG_BINARY /d %AccentPalette% /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent /v StartColorMenu /t REG_DWORD /d %StartColorMenu% /f
reg add HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent /v AccentColorMenu /t REG_DWORD /d %AccentColorMenu% /f
