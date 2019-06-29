set "X_PEMaterial=%X%\PEMaterial"

if exist PEMaterial (
  xcopy /Y /E PEMaterial "%X_PEMaterial%\"
  set PE_LOADER=LUA
)
call CheckPatch "00-Configures\z-PECMD"
if "%HasPatch%"=="true"  (
  set PE_LOADER=PECMD
)

copy /y PEMaterial\unattend.xml "%X_SYS%\"
if "%WB_PE_ARCH%"=="x86" (
  call TextReplace "%X_SYS%\unattend.xml" "processorArchitecture=#qamd64#q" "processorArchitecture=#qx86#q"
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
