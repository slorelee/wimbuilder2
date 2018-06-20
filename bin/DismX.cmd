if exist "%~dp0Dism10_x86\Dism.exe" (
  "%~dp0Dism10_x86\Dism.exe" %*
) else (
  Dism.exe %*
)
