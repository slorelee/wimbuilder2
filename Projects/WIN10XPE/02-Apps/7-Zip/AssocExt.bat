rem 7z-Assoc
if "x%opt[7-zip.selected_assoc_exts]%"=="x" goto :EOF

set "_7z_AssocExt_File=%X_Startup%\BeforeShell\7z-AssocExt.reg"
set _ExtIco[7z]=0
set _ExtIco[zip]=1
set _ExtIco[rar]=3
set _ExtIco[cab]=7
set _ExtIco[iso]=8
set _ExtIco[wim]=15

call :GEN_EXTS_REG "%opt[7-zip.selected_assoc_exts]%"
goto :EOF

:GEN_EXTS_REG
echo Windows Registry Editor Version 5.00 > "%_7z_AssocExt_File%"
echo. >> "%_7z_AssocExt_File%"

for %%i in (%~1) do (
  call :GEN_EXT_REG %%i
)
set __ico=
goto :EOF

:GEN_EXT_REG
call set __ico=%%_ExtIco[%1]%%
if "x%__ico%"=="x" set __ico=0
(
  echo [HKEY_CLASSES_ROOT\.%1]
  echo @="7-Zip.%1"
  echo [HKEY_CLASSES_ROOT\7-Zip.%1]
  echo @="%1 Archive"
  echo [HKEY_CLASSES_ROOT\7-Zip.%1\DefaultIcon]
  echo @="X:\\Program Files\\7-Zip\\7z.dll,%__ico%"
  echo [HKEY_CLASSES_ROOT\7-Zip.%1\shell\open\command]
  echo @="\"X:\\Program Files\\7-Zip\\7zFM.exe\" \"%%1\""
  echo.
) >> "%_7z_AssocExt_File%"
