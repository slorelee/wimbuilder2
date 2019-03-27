call X2X
ren "%X_SYS%\Pecmd_%WB_PE_ARCH%.exe" Pecmd.exe
del /q "%X_SYS%\Pecmd_x*.exe"
del /q "%X_SYS%\wallpaperhost.exe"

if exist "%WB_PROJECT_PATH%\_CustomFiles_\Pecmd.ini" copy /y "%WB_PROJECT_PATH%\_CustomFiles_\Pecmd.ini" "%X_SYS%\"

rem copy /y Pecmd_%WB_PE_ARCH%.exe "%X_SYS%\Pecmd.exe"
rem copy /y Pecmd.ini "%X_SYS%\"
