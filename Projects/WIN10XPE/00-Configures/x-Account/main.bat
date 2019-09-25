rem update UI_LogonPE.jcfg
set "_UI_LogonPE_jcfg=%X_PEMaterial%\UI_LogonPE.jcfg"
if not exist "%_UI_LogonPE_jcfg%" set _UI_LogonPE_jcfg=

if not "x%_UI_LogonPE_jcfg%"=="x" (
  if not "x%opt[account.SYSTEM_logon_pass]%"=="x" (
    call TextReplace "%_UI_LogonPE_jcfg%" "#qshadow#q:#qAdministrator:;\\nSYSTEM:;#q" "#qshadow#q:#qAdministrator:%opt[account.admin_logon_pass]%;\\nSYSTEM:%opt[account.SYSTEM_logon_pass]%;#q"
  )
)

if "x%opt[account.admin_enabled]%"=="xtrue" (
  pushd Admin
  call SwitchToAdmin.bat
  popd
)

set _UI_LogonPE_jcfg=
