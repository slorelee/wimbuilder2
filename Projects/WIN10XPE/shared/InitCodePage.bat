rem init code page
set WB_PE_ACP=*
set WB_PE_OEMCP=*

rem known code page
if "x%WB_PE_LANG%"=="xzh-CN" set "WB_PE_ACP=936" && set "WB_PE_OEMCP=936" && goto :END_CODEPAGE
if "x%WB_PE_LANG%"=="xzh-TW" set "WB_PE_ACP=950" && set "WB_PE_OEMCP=950" && goto :END_CODEPAGE
if "x%WB_PE_LANG%"=="xen-US" set "WB_PE_ACP=1252" && set "WB_PE_OEMCP=437" && goto :END_CODEPAGE

for /f "tokens=3" %%i in ('reg query HKLM\Tmp_SYSTEM\ControlSet001\Control\Nls\CodePage /v ACP') do (
  set WB_PE_ACP=%%i
)
for /f "tokens=3" %%i in ('reg query HKLM\Tmp_SYSTEM\ControlSet001\Control\Nls\CodePage /v OEMCP') do (
  set WB_PE_OEMCP=%%i
)

:END_CODEPAGE
echo Got ANSI code page: %WB_PE_ACP%
echo Got OEM code page: %WB_PE_OEMCP%
