if "x%~1"=="x" goto :EOF
if "x%opt[build.custom_iso]%"=="xtrue" (
  if exist "%_USER_CUSTOMFILES_%\_CustomISO_.bat" (
    call "%_USER_CUSTOMFILES_%\_CustomISO_.bat" %*
    goto :EOF
  )
)
call :%1 "%~2"
goto :EOF

rem ===================================
:PreISO
set WB_ISO_

goto :EOF

rem ===================================
:MakeISO
if not "x%opt[iso.attended_boot]%"=="xtrue" (
  set EFI_BIN=efisys_noprompt.bin
  ren "%ISO_PATH%\boot\bootfix.bin" bootfix.bin.bak
) else (
  ren "%ISO_PATH%\boot\bootfix.bin.bak" bootfix.bin
)

if "x%opt[iso.x_exFAT]%"=="xtrue" (
  xcopy /d /c /y "%WB_ROOT%\Projects\%WB_PROJECT%\zz-ISO\boot.sdi" "%ISO_PATH%\boot\boot.sdi"
) else (
  xcopy /E /Y "%WB_SRC_FOLDER%\boot\boot.sdi" "%ISO_PATH%\boot\boot.sdi"
)

if not "x%opt[iso.edit_bcd]%"=="xtrue" goto :EOF
set BCD_BOOTMENUPOLICY=Standard
if "x%opt[iso.loading_progress]%"=="xtrue" (
  set BCD_BOOTMENUPOLICY=Legacy
)
"%SystemRoot%\sysnative\cmd.exe" /c bcdedit.exe /store "%ISO_PATH%\boot\bcd" /set {default} bootmenupolicy %BCD_BOOTMENUPOLICY%
del /a "%ISO_PATH%\boot\bcd.LOG*"

goto :EOF

rem ===================================
:PostISO
if "x%~1"=="x" echo Failed to make ISO file.&&goto :EOF
echo %WB_ISO_PATH%

goto :EOF
