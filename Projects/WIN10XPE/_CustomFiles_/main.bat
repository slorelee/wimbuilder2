if not exist MyCustom goto :EOF

for /f %%i in ('dir /b MyCustom\*.bat') do (
  echo Applying MyCustom\%%i ...
  call MyCustom\%%i
)

if exist PEMaterial (
  xcopy /Y /E PEMaterial "%X%\PEMaterial\"
)
