if not "x%opt[slim.safe]%"=="xtrue" goto :EOF
echo Safely Sliming...

rem init code page
set WB_PE_CODEPAGE=
for /f "tokens=3" %%i in ('reg query HKLM\Tmp_SYSTEM\ControlSet001\Control\Nls\CodePage /v ACP') do (
  set WB_PE_CODEPAGE=%%i
)
if "x%WB_PE_CODEPAGE%"=="x" set WB_PE_CODEPAGE=437
echo Got code page: %WB_PE_CODEPAGE%

call :_Slim_font
call :_Slim_keyboard
call :_Slim_migration
call :_Slim_useless

call :KEEP_DONE
goto :EOF

:_Slim_font
rem ==============================================
call :KEEP_FILES \Windows\Fonts\ "app%WB_PE_CODEPAGE%.fon,consola.ttf,marlett.ttf,micross.ttf,tahoma.ttf,segmdl2.ttf,tahoma.ttf,tahomabd.ttf"
call :KEEP_FILES \Windows\Fonts\ "svgafix.fon,svgasys.fon,vga%WB_PE_CODEPAGE%.fon,vgafix.fon,vgafixr.fon,vgaoem.fon,vgasys.fon,vgasysr.fon"
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
if "x%WB_PE_LANG%"=="xru-RU" (
  call :KEEP_FILES \Windows\Fonts\ "cour.ttf,courbd.ttf,courbi.ttf,courer.fon,lucon.ttf,serifer.fon"
)
if "x%WB_PE_LANG%"=="xko-KR" (
  call :KEEP_FILES \Windows\Fonts\ "gulim.ttc,malgun.ttf"
)
del /a /f /q "%X_WIN%\Fonts\*.*"
goto :EOF


:_Slim_keyboard
rem ==============================================
call :KEEP_FILE \Windows\System32\KBDUS.DLL
rem TODO: other %WB_PE_LANG%
if "x%WB_PE_LANG%"=="xru-RU" (
  call :KEEP_FILE \Windows\System32\KBDRU.DLL
)
del /a /f /q "%X_SYS%\KB*.DLL"

call :KEEP_FILES \Windows\System32\ "kd.dll,kdcom.dll"
del /a /f /q "%X_SYS%\kd*.dll"
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

del /a /f /q "%X_SYS%\config\BBI"
del /a /f /q "%X_SYS%\config\BCD-Template"
del /a /f /q "%X_SYS%\config\ELAM"

rd /q /s "%X_SYS%\config\Journal"
rd /q /s "%X_SYS%\config\RegBack"
rd /q /s "%X_SYS%\config\TxR"
rd /q /s "%X_SYS%\config\systemprofile"

rd /q /s "%X_SYS%\DiagSvcs"
rd /q /s "%X_SYS%\SMI"
rd /q /s "%X_SYS%\WindowsPowerShell"

rd /q /s "%X_SYS%\wbem\Repository"
md "%X_SYS%\wbem\Repository"
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
