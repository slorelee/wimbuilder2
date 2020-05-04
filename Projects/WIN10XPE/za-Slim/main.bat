rem // Disable Telemetry
rem reg add HKLM\Tmp_System\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener /v Start /t REG_DWORD /d 0 /f
rem reg add HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection /v AllowTelemetry /t REG_DWORD /d 0 /f
rem //-
rem // Disable Diagnostic Telemetry Service (DiagTrack and diagnosticshub.standardcollector.service are disabled)

rd /s /q "%X_WIN%\DiagTrack"
rd /s /q "%X_SYS%\DiagSvcs"
del /f /a /q "%X_SYS%\diagER.dll"
del /f /a /q "%X_SYS%\diagtrack.dll"

if "x%opt[slim.winre_sources]%"=="xtrue" rd /s /q "%X%\sources"

rem //-
rem // WMI Repository will be rebuilt, refresh at startup
if "x%opt[slim.wbem_repository]%"=="xtrue" (
  rd /s /q "%X_SYS%\wbem\AutoRecover"
  rd /s /q "%X_SYS%\wbem\Logs"
  rd /s /q "%X_SYS%\wbem\Repository"
  rd /s /q "%X_SYS%\wbem\tmf"
  rd /s /q "%X_SYS%\wbem\xml"
)

if "x%WB_PE_LANG%"=="xzh-TW" set opt[slim.font.mingliu]=false
if "x%opt[slim.font.mingliu]%"=="xtrue" (
  del /f /a /q "%X_WIN%\Fonts\mingliu.ttc"
)

rem replace small files

if "x%opt[slim.small_fonts]%"=="xtrue" (
  for /f "delims=" %%i in ('dir /b "%V%\CustomResources\SmallFonts"') do (
    if exist "%X_WIN%\Fonts\%%i" copy /Y "%V%\CustomResources\SmallFonts\%%i" "%X_WIN%\Fonts\"
  )
)

if "x%opt[slim.small_imageresdll]%"=="xtrue" (
  if "%opt[support.wow64]%"=="true" (
    if not exist "%X_WIN%\SystemResources\imageres.dll.mun" xcopy  /E /Y "%V%\CustomResources\SmallDlls\imageres.dll"  "%X_WIN%\SysWOW64\imageres.dll"
  )
)

set opt[component.hta]=false
if exist "%X_SYS%\mshta.exe" (
  set opt[component.hta]=true
) else (
  set opt[slim.hta]=false
)

set opt[component.speech]=false
if exist "%X_WIN%\Speech" (
  set opt[component.speech]=true
) else (
  set opt[slim.speech]=false
  set opt[slim.narrator]=false
)

if "x%opt[slim.speech]%"=="xtrue" (
  set opt[slim.narrator]=true
)

set opt[component.narrator]=false
if exist "%X_SYS%\Narrator.exe" (
  set opt[component.narrator]=true
) else (
  set opt[slim.narrator]=false
)

rem services management extended page needs jscript.dll,jscript9.dll,mshtml.dll

set mmc_required=0
if "x%opt[component.mmc]%"=="xtrue" (
  if not "x%opt[shell.app]%"=="xwinxshell" (
    set mmc_required=1
  )
)

if "x%opt[slim.jscript]%"=="xtrue" (
  del /a /f /q "%X_SYS%\Chakra.dll"
  del /a /f /q "%X_SYS%\Chakradiag.dll"
  del /a /f /q "%X_SYS%\Chakrathunk.dll"

  if %mmc_required% EQU 0 (
    del /a /f /q "%X_SYS%\jscript.dll"
    del /a /f /q "%X_SYS%\jscript9.dll"
  )

  del /a /f /q "%X_SYS%\jscript9diag.dll"
)

if "x%opt[component.bitlocker]%"=="xtrue" (
  rem bitlocker feature needs HTA and WMI
  rem set opt[slim.hta]=false
  set opt[slim.wmi]=false
)

if "x%opt[slim.hta]%"=="xtrue" (
  del /a /f /q "%X_SYS%\mshta.exe"

  if %mmc_required% EQU 0 (
    del /a /f /q "%X_SYS%\mshtml.dll"
  )
  del /a /f /q "%X_SYS%\mshtml.tlb"
  del /a /f /q "%X_SYS%\mshtmled.dll"
  call :DEL_CATLOG WinPE-HTA-Package "*"
)
set mmc_required=

if "x%opt[slim.wmi]%"=="xtrue" (
  del /a /f /q "%X_SYS%\wmi*"
  del /a /f /q "%X_SYS%\%WB_PE_LANG%\wmi*"
  rem disk management
  if not "x%opt[component.mmc]%"=="xtrue" (
    del /a /f /q "%X_SYS%\wbem\wmi*"
    del /a /f /q "%X_SYS%\wbem\%WB_PE_LANG%\wmi*"
  )
  call :DEL_CATLOG "WMI,StorageWMI,WMIProvider,WmiClnt"
)

if "x%opt[slim.speech]%"=="xtrue" (
  rd /s /q "%X_WIN%\Speech"
  rd /s /q "%X_SYS%\Speech"
  del /a /f /q "%X_SYS%\SRH.dll"
  del /a /f /q "%X_SYS%\srhelper.dll"
  del /a /f /q "%X_SYS%\srms*.dat"
  call :DEL_CATLOG "SRT,SRH,Speech"

  rem narrator.exe
  del /a /f /q "%X_SYS%\Narrator*"
  del /a /f /q "%X_SYS%\%WB_PE_LANG%\Narrator*"
  call :DEL_CATLOG WinPE-Narrator-Package "*"
)

if "x%opt[slim.dism]%"=="xtrue" (
  rd /s /q "%X_SYS%\Dism"
  del /f /a /q "%X_SYS%\dism.exe"
)

if "x%opt[slim.ieframedll]%"=="xtrue" (
  del /a /f /q "%X_WIN%\SystemResources\ieframe.dll.mun"
  del /a /f /q "%X_SYS%\ieframe.dll"
  del /a /f /q "%X_SYS%\%WB_PE_LANG%\ieframe.dll.mui"
)

if "x%opt[slim.winboot]%"=="xtrue" (
    rem del /f /a /q "%X_WIN%\BootDebuggerFiles.ini"
    rd /s /q "%X_WIN%\Boot\EFI"
    rd /s /q "%X_WIN%\Boot\DVD"
    rd /s /q "%X_WIN%\Boot\PCAT"
    rd /s /q "%X_WIN%\Boot\Misc"
    del /f /a /q "%X_WIN%\Boot\Fonts\cht_boot.ttf"
    del /f /a /q "%X_WIN%\Boot\Fonts\chs_boot.ttf"
    del /f /a /q "%X_WIN%\Boot\Fonts\jpn_boot.ttf"
    del /f /a /q "%X_WIN%\Boot\Fonts\kor_boot.ttf"
    del /f /a /q "%X_WIN%\Boot\Fonts\msjh_boot.ttf"
    del /f /a /q "%X_WIN%\Boot\Fonts\msjhn_boot.ttf.ttf"
    rd /s /q "%X_WIN%\Boot\PXE\*.com"
    rd /s /q "%X_WIN%\Boot\PXE\*.n12"
    rd /s /q "%X_WIN%\Boot\PXE\WdsConfig.inf"
)

call Slim_Safely.bat
call Slim_Ultra.bat

rem already removed in _pre_wim.bat
goto :EOF

call :REMOVE_MUI Windows\Boot\EFI
call :REMOVE_MUI Windows\Boot\PCAT
call :REMOVE_MUI Windows\System32
goto :EOF

:REMOVE_MUI
rem always keep en-US
call :_REMOVE_MUI "%~1" "ar-SA bg-BG cs-CZ da-DK de-DE el-GR en-GB es-ES es-MX et-EE fi-FI fr-CA fr-FR"
call :_REMOVE_MUI "%~1" "he-IL hr-HR hu-HU it-IT ja-JP ko-KR  lt-LT lv-LV nb-NO nl-NL pl-PL pt-BR pt-PT"
call :_REMOVE_MUI "%~1" "qps-ploc ro-RO ru-RU sk-SK sl-SI sr-Latn-RS sv-SE th-TH tr-TR uk-UA zh-CN zh-TW"
goto :EOF

:_REMOVE_MUI
for %%i in (%~2) do (
  if not "x%%i"=="x%WB_PE_LANG%" (if exist "%X%\%~1\%%i" rd /s /q "%X%\%~1\%%i")
)
goto :EOF

:DEL_CATLOG
set _CAT_FIX=-
if "x%~2"=="x*" set _CAT_FIX=
for %%i in (%~1) do (
  del /a /f /q "%X_SYS%\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\*%_CAT_FIX%%%i%_CAT_FIX%*"
)
goto :EOF
