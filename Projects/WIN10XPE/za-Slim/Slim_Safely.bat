if not "x%opt[slim.safe]%"=="xtrue" goto :EOF
echo Safely Sliming...

call :_Slim_font
call :_Slim_keyboard
call :_Slim_nls
call :_Slim_migration
call :_Slim_useless

call :KEEP_DONE
goto :EOF

:_Slim_font
rem ==============================================
call :KEEP_FILES \Windows\Fonts\ "app%WB_PE_OEMCP%.fon,consola.ttf,marlett.ttf,micross.ttf,tahoma.ttf,segmdl2.ttf,tahoma.ttf,tahomabd.ttf"
call :KEEP_FILES \Windows\Fonts\ "svgafix.fon,svgasys.fon,vga%WB_PE_OEMCP%.fon,vgafix.fon,vgafixr.fon,vgaoem.fon,vgasys.fon,vgasysr.fon"
if "x%WB_PE_LANG%"=="xen-US" (
  call :KEEP_FILES \Windows\Fonts\ "segoeui.ttf,segoeuib.ttf,segoeuii.ttf"
)
if "x%WB_PE_LANG%"=="xzh-CN" (
  call :KEEP_FILES \Windows\Fonts\ "msyh.ttc,s8514fix.fon,s8514oem.fon,s8514sys.fon"
  call :KEEP_FILES \Windows\Fonts\ "segoeuib.ttf,seguisbi.ttf,seguisym.ttf,simsun.ttc,wingding.ttf"
  del "%X%\[KEEP]\Windows\Fonts\tahomabd.ttf"

  rem volume mixer
  call :KEEP_FILE \Windows\Fonts\Malgun.ttf
)
if "x%WB_PE_LANG%"=="xzh-TW" (
  call :KEEP_FILES \Windows\Fonts\ "mingliub.ttc,mingliu.ttc,kaiu.ttf,msjh.ttc,msjhbd.ttc,msjhl.ttc"
)
if "x%WB_PE_LANG%"=="xru-RU" (
  call :KEEP_FILES \Windows\Fonts\ "cour.ttf,courbd.ttf,courbi.ttf,courer.fon,lucon.ttf,serifer.fon"
)
if "x%WB_PE_LANG%"=="xko-KR" (
  call :KEEP_FILES \Windows\Fonts\ "gulim.ttc,malgun.ttf"
)
if "x%WB_PE_LANG%"=="xja-JP" (
  call :KEEP_FILES \Windows\Fonts\ "msgothic.ttc,YuGothM.ttc"
)
del /a /f /q "%X_WIN%\Fonts\*.*"
goto :EOF


:_Slim_keyboard
rem ==============================================
set _LocaleId=
for /f "tokens=3" %%l in ('reg query "HKLM\Tmp_SYSTEM\ControlSet001\Control\Nls\Locale" /ve') do (
  set _LocaleId=%%l
)
if "x%_LocaleId%"=="x" (
  echo [WARNING] Failed to get the locale id.
  goto :EOF
)

set _LayoutFile=
for /f "tokens=4" %%l in ('reg query "HKLM\Tmp_SYSTEM\ControlSet001\Control\Keyboard Layouts\%_LocaleId%" /v "Layout File"') do (
  set _LayoutFile=%%l
)
echo [INFO] Got LocaleId:%_LocaleId%
echo [INFO] Got LayoutFile:%_LayoutFile%

call :KEEP_FILE \Windows\System32\KBDUS.DLL
if /i "x%_LayoutFile%"=="xKBDUS.DLL" set _LayoutFile=
if not "x%_LayoutFile%"=="x" (
  call :KEEP_FILE "\Windows\System32\%_LayoutFile%"
)
set _LocaleId=
set _LayoutFile=
del /a /f /q "%X_SYS%\KB*.DLL"
goto :EOF

:_Slim_nls
if "x%WB_PE_ACP%"=="x*" goto :EOF
call :KEEP_FILES \Windows\System32\ "C_1252.NLS,C_437.NLS,C_20127.NLS"
if not "x%WB_PE_ACP%"=="x1252" (
  call :KEEP_FILE \Windows\System32\C_%WB_PE_ACP%.NLS
)
if not "x%WB_PE_OEMCP%"=="x437" (
  call :KEEP_FILE \Windows\System32\C_%WB_PE_OEMCP%.NLS
)
if exist "%X_SYS%\C_20%WB_PE_OEMCP%.NLS" (
  call :KEEP_FILE \Windows\System32\C_20%WB_PE_OEMCP%.NLS
)
if exist "%X_SYS%\C_1251.NLS" (
  call :KEEP_FILE \Windows\System32\C_1251.NLS
)
del /a /f /q "%X_SYS%\C_*.NLS"
goto :EOF

:_Slim_migration
rem ==============================================
del /a /f /q "%X_SYS%\migapp.xml"
del /a /f /q "%X_SYS%\migcore.dll"
del /a /f /q "%X_SYS%\migisol.dll"
del /a /f /q "%X_SYS%\migres.dll"
del /a /f /q "%X_SYS%\migstore.dll"
del /a /f /q "%X_SYS%\migsys.dll"

del /a /f /q "%X_SYS%\SFCN.dat"
del /a /f /q "%X_SYS%\SFL*.dat"
del /a /f /q "%X_SYS%\SFPAT*.inf"

rd /q /s "%X_SYS%\migration"
goto :EOF


:_Slim_useless
rem ==============================================
rd /q /s "%X_SYS%\AdvancedInstallers"

rem del /a /f /q "%X_SYS%\config\BBI"
rem del /a /f /q "%X_SYS%\config\BCD-Template"
rem del /a /f /q "%X_SYS%\config\ELAM"

rd /q /s "%X_SYS%\config\Journal"
rd /q /s "%X_SYS%\config\RegBack"
rd /q /s "%X_SYS%\config\TxR"
rd /q /s "%X_SYS%\config\systemprofile"

rd /q /s "%X_SYS%\DiagSvcs"
rd /q /s "%X_SYS%\SMI"
rd /q /s "%X_SYS%\WindowsPowerShell"

rem Key Distrubution Service Provider
del /a /f /q "%X_SYS%\KdsCli.dll"

rem Network Kernel Debug Extensibility Modules
rem del /a /f /q "%X_SYS%\kd_*.dll"

goto :EOF



rem ==============================================
rem ==============================================
:KEEP_FILES
echo move "%~1%~2" "%X%\[KEEP]%~1"
if not exist "%X%\[KEEP]%~1" mkdir "%X%\[KEEP]%~1"
for %%i in (%~2) do (
  move "%X%%~1%%i" "%X%\[KEEP]%~1"
)
goto :EOF

:KEEP_FILE
echo move "%~1" "%X%\[KEEP]%~p1"
if not exist "%X%\[KEEP]%~p1" mkdir "%X%\[KEEP]%~p1"
move "%X%%~1" "%X%\[KEEP]%~1"
goto :EOF

:KEEP_DONE
rem restore [KEEP]
if not exist "%X%\[KEEP]" goto :EOF
xcopy /S /E /Q /H /K /Y "%X%\[KEEP]" "%X%\"
rd /s /q "%X%\[KEEP]"
goto :EOF
