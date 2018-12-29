
rem Fbwf Cache Size. Limited to 1024 Mb with x86
set _fbwf_size=%opt[config.fbwf.cache]%
if "x%_fbwf_size%"=="x" set _fbwf_size=1024
if %_fbwf_size% GTR 1024 (
  if "%WB_PE_ARCH%"=="x86" set _fbwf_size=1024
)
reg add HKLM\Tmp_System\ControlSet001\Services\FBWF /v WinPECacheThreshold /t REG_DWORD /d %_fbwf_size% /f
set _fbwf_size=

rem NumLock on/off
if not "x%opt[system.numlock]%"=="xfalse" (
    reg add "HKLM\Tmp_Default\Control Panel\Keyboard" /v InitialKeyboardIndicators /d 2 /f
)
