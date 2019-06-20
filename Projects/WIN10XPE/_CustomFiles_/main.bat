set "X_PEMaterial=%X%\PEMaterial"

if exist PEMaterial (
  xcopy /Y /E PEMaterial "%X_PEMaterial%\"
  set PE_LOADER=LUA
)
call CheckPatch "00-Configures\z-PECMD"
if "%HasPatch%"=="true"  (
  set PE_LOADER=PECMD
)

call :Apply_MyCutom
goto :EOF


:Apply_MyCutom
if not exist MyCustom goto :EOF

for /f %%i in ('dir /b MyCustom\*.bat') do (
  echo Applying MyCustom\%%i ...
  call MyCustom\%%i
)
goto :EOF
