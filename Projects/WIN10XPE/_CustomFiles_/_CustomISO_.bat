if "x%~1"=="x" goto :EOF
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
  ren "%WB_ROOT%\%ISO_DIR%\boot\bootfix.bin" bootfix.bin.bak
) else (
  ren "%WB_ROOT%\%ISO_DIR%\boot\bootfix.bin.bak" bootfix.bin
)


if not "x%opt[iso.edit_bcd]%"=="xtrue" goto :EOF
set BCD_BOOTMENUPOLICY=Standard
if "x%opt[iso.loading_progress]%"=="xtrue" (
  set BCD_BOOTMENUPOLICY=Legacy
)
"%SystemRoot%\sysnative\cmd.exe" /c bcdedit.exe /store "%WB_ROOT%\%ISO_DIR%\boot\bcd" /set {default} bootmenupolicy %BCD_BOOTMENUPOLICY%
del /a "%WB_ROOT%\%ISO_DIR%\boot\bcd.LOG*"

goto :EOF

rem ===================================
:PostISO
if "x%~1"=="x" echo Failed to make ISO file.&&goto :EOF
echo %WB_ISO_PATH%

goto :EOF
