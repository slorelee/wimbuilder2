
call ComputerName.bat
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18" /v ProfileImagePath /d X:\Users\Default /f

set _fbwf_size=%opt[config.fbwf.cache]%
call :X_DRVTYPE_EXFAT

if "x%_fbwf_size%"=="x" set _fbwf_size=1024
if "x%_fbwf_size%"=="x128GB" goto :USE_WES_FBWF

rem Fbwf Cache Size. Limited to 1024 Mb with x86
if %_fbwf_size% GTR 1024 (
    if "%WB_PE_ARCH%"=="x86" set _fbwf_size=1024
)
if "%_fbwf_size%"=="4096" set /a _fbwf_size-=1
reg add HKLM\Tmp_System\ControlSet001\Services\FBWF /v WinPECacheThreshold /t REG_DWORD /d %_fbwf_size% /f

:USE_WES_FBWF
if exist fbwf_%_fbwf_size%.cfg (
  echo Enable %_fbwf_size% MB cache size with Windows Embedded Standard's fbwf driver
  copy /y fbwf_%_fbwf_size%.cfg "%X_WIN%\fbwf.cfg"
  copy /y fbwf.sys "%X_SYS%\drivers\fbwf.sys"
  rem support exFAT boot.sdi
  reg add HKLM\Tmp_SYSTEM\ControlSet001\Services\exfat /v Start /t REG_DWORD /d 0 /f
)

set _fbwf_size=

rem NumLock on/off
if not "x%opt[system.numlock]%"=="xfalse" (
    reg add "HKLM\Tmp_Default\Control Panel\Keyboard" /v InitialKeyboardIndicators /d 2 /f
)
goto :EOF

:X_DRVTYPE_EXFAT
rem http://bbs.wuyou.net/forum.php?mod=viewthread&tid=421466
rem by zhuma12345678

if not "x%opt[iso.x_exFAT]%"=="xtrue" goto :EOF
if "x%_fbwf_size%"=="x" set _fbwf_size=128GB
if "x%_fbwf_size%"=="x128GB" goto :EOF
if %_fbwf_size% LSS 4096 set _fbwf_size=128GB

goto :EOF
