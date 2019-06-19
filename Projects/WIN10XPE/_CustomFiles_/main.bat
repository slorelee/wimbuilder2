set "X_PEMaterial=%X%\PEMaterial"

if exist PEMaterial (
  xcopy /Y /E PEMaterial "%X_PEMaterial%\"
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
