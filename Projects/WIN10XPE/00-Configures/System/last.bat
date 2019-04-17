
call ComputerName.bat
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18" /v ProfileImagePath /d X:\Users\Default /f


rem Fbwf Cache Size. Limited to 1024 Mb with x86
set _fbwf_size=%opt[config.fbwf.cache]%
if "x%_fbwf_size%"=="x" set _fbwf_size=1024
if %_fbwf_size% GTR 1024 (
  if "%WB_PE_ARCH%"=="x86" set _fbwf_size=1024
)
reg add HKLM\Tmp_System\ControlSet001\Services\FBWF /v WinPECacheThreshold /t REG_DWORD /d %_fbwf_size% /f
if exist fbwf_%_fbwf_size%.cfg (
  echo Enable %_fbwf_size% MB cache size with Windows Embedded Standard's fbwf driver
  copy /y fbwf_%_fbwf_size%.cfg "%X_WIN%\fbwf.cfg"
  copy /y fbwf.sys "%X_SYS%\drivers\fbwf.sys"
)
set _fbwf_size=

rem NumLock on/off
if not "x%opt[system.numlock]%"=="xfalse" (
    reg add "HKLM\Tmp_Default\Control Panel\Keyboard" /v InitialKeyboardIndicators /d 2 /f
)
