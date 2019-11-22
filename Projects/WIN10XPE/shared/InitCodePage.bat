rem init code page
set WB_PE_CODEPAGE=
for /f "tokens=3" %%i in ('reg query HKLM\Tmp_SYSTEM\ControlSet001\Control\Nls\CodePage /v ACP') do (
  set WB_PE_CODEPAGE=%%i
)
if "x%WB_PE_LANG%"=="xzh-CN" set WB_PE_CODEPAGE=936
if "x%WB_PE_CODEPAGE%"=="x" set WB_PE_CODEPAGE=437
echo Got code page: %WB_PE_CODEPAGE%
