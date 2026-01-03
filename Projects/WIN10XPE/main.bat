
echo %cd%

set opt[build.wim]=customed
if "%WB_BASE%"=="winre.wim" (
  set opt[build.wim]=winre
)
if "x%opt[build.adk]%"=="xtrue" (
  set opt[build.wim]=winpe
)

echo.
echo \033[97;44mBuild Options:|cmdcolor.exe
set opt

echo.
echo \033[97;44mBuild Selection:|cmdcolor.exe
type "%WB_TMP_PATH%\_patches_selected.txt"
echo.

rem Dism /Get-Packages /Image:"%_WB_MNT_DIR%"

cd /d "%~dp0"

call CheckPatch "00-Configures\Build"
if "x%HasPatch%"=="false" (
    opt[build.registry.software]=merge
)

if "x%opt[build.registry.software]%"=="xfull" (
    call AddFiles \Windows\System32\config\SOFTWARE
    set REGCOPY_SKIP_SOFTWARE=1
)

if "x%opt[build.load_hive]%"=="xtrue" (
  call PERegPorter.bat Src LOAD 1>nul
  call PERegPorter.bat Tmp LOAD 1>nul
)

if /i "%WB_BASE%"=="test\boot.wim" (
  for /f "tokens=3 usebackq" %%i in (`reg query "HKLM\Src_SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild`) do set /a VER[3]=%%i
)

echo Update WB_PE_BUILD, VER[] environment variables with %WB_SRC%
for /f "tokens=3 usebackq" %%i in (`reg query "HKLM\Src_SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v UBR`) do set /a WB_PE_BUILD=%%i
set VER[4]=%WB_PE_BUILD%
set VER[3.4]=%VER[3]%.%VER[4]%

set VER

if "%VER[3]%"=="22621" (
  if %VER[4]% GEQ 2428 (
    set VER[3]=22631
    set VER[3.4]=22631.%VER[4]%
    set WB_PE_VER=10.0.22631
    echo [UPDATED]:WB_PE_VER=10.0.22631
    echo [UPDATED]:VER[3]=22631
    echo [UPDATED]:VER[3.4]=22631.%VER[4]%
  )
)

rem Windows.UI.Xaml.Resources.*.dll

set VER_XAMLRES=
if %VER[3]% GTR 17000 set VER_XAMLRES=rs4
if %VER[3]% GTR 17700 set VER_XAMLRES=rs5
if %VER[3]% GTR 18300 set VER_XAMLRES=19h1
if %VER[3]% GTR 21000 set VER_XAMLRES=21h1
rem for future version
if %VER[3]% GTR 23000 set VER_XAMLRES=*
set VER_XAMLRES=.%VER_XAMLRES%
if "x%VER_XAMLRES%"=="x." set VER_XAMLRES=

rem https://learn.microsoft.com/en-us/windows/release-health/windows11-release-information
rem 22631.5335, 26100.4061 (May 2025 update), 27842.1000
rem 22631.5768, 26100.4946 (August 2025 update), 26200.*, 27909.1
set VER_202505_LATER=0
set VER_202508_LATER=0
if %VER[3]% GEQ 22631 (
  if %VER[4]% GEQ 5335 (
    set VER_202505_LATER=1
  )
  if %VER[4]% GEQ 5768 (
    set VER_202508_LATER=1
  )
)

if %VER[3]% GEQ 26100 (
  if %VER[4]% GEQ 4061 (
    set VER_202505_LATER=1
  )
  if %VER[4] GTR 4946 (
    set VER_202508_LATER=1
  )
)

if %VER[3]% GEQ 27842 (
    set VER_202505_LATER=1
)

if %VER[3]% GEQ 27909 (
    set VER_202508_LATER=1
)
echo VER_202505_LATER=%VER_202505_LATER%
echo VER_202508_LATER=%VER_202508_LATER%

call CheckPatch "01-Components\zh-RuntimeKits"
if "x%HasPatch%"=="xfalse" (
  set opt[build.wow64support]=false
)

if "x%opt[build.wow64support]%"=="xtrue" (
  if not "x%WB_PE_ARCH%"=="xx64" set opt[build.wow64support]=false
)

set opt[support.wow64]=%opt[build.wow64support]%
if "%opt[support.wow64]%"=="true" (
  set ADDFILES_SYSWOW64=1
)

set System32OrSysWOW64=SysWOW64
 if not "x%WB_PE_ARCH%"=="xx64" set System32OrSysWOW64=System32

rem call CheckPatch "01-Components\02-Network"
rem set opt[support.network]=%HasPatch%

call CheckPatch "01-Components\03-Audio"
set opt[support.audio]=%HasPatch%

call shared\InitCodePage.bat

echo.
echo \033[97;44mAvailable Environment Variables\033[97;45m(For Developer):|cmdcolor.exe
set WB_
set VER[3]
set VER[4]
set VER[3.4]
echo.
echo %%X%%=%X%
set X_
echo System32OrSysWOW64=%System32OrSysWOW64%
echo.
set _CUSTOMFILES_
set _USER_
echo V_APP=%V_APP%
echo V_USER=%V_USER%
echo V=%V%
echo %%V%%\%%APP_CACHE%%=%V%\%APP_CACHE%
echo.
set APP_
echo.
set _V
echo.
echo Mounted KEYs of %WB_SRC%'s HIVEs
echo   - HKEY_LOCAL_MACHINE\Src_DEFAULT
echo   - HKEY_LOCAL_MACHINE\Src_DRIVERS
echo   - HKEY_LOCAL_MACHINE\Src_SOFTWARE
echo   - HKEY_LOCAL_MACHINE\Src_SYSTEM
echo.
echo Mounted KEYs of %WB_BASE_PATH%'s HIVEs
echo   - HKEY_LOCAL_MACHINE\Tmp_DEFAULT
echo   - HKEY_LOCAL_MACHINE\Tmp_DRIVERS
echo   - HKEY_LOCAL_MACHINE\Tmp_SOFTWARE
echo   - HKEY_LOCAL_MACHINE\Tmp_SYSTEM
echo.

if "x%WB_SKIP_UFR%"=="x1" goto :END_UPDATE_FILES_ACL
rem update files ACL Right
call :cecho PHRASE "PHRASE:updating files' ACL rights"
if "x%WB_STRAIGHT_MODE%"=="x" pause
call :techo "Updating...(Please, be patient)"
call TrustedInstallerRight "%_WB_MNT_DIR%" 1>nul
if not "%GetLastError%"=="0" call :CLEANUP
call :techo "Update files with Administrators' FULL ACL rights successfully."
echo.
:END_UPDATE_FILES_ACL

call CheckPatch "za-Slim"
if "x%HasPatch%"=="xtrue" (
  echo \033[96mApplying Patch: %WB_PROJECT_PATH%\za-Slim\main.bat | cmdcolor.exe
  pushd za-Slim
  call main.bat
  popd
)

icacls "%X%\Windows\System32" /grant *S-1-1-0:(OI)(CI)(F)
