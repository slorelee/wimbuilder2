rem https://www.chrome-portable.com/index.php/google-chrome-offline-installer
rem https://dl.google.com/release2/chrome/AMQFLHv8Muh_ExYptfSwv2g_81.0.4044.113/81.0.4044.113_chrome_installer.exe

if not "x%opt[PEMApp.chrome]%"=="xtrue" goto :EOF

if "x%opt[PEMApp.chrome.dl_url]%"=="x" goto :EOF
call app pull "%opt[PEMApp.chrome.dl_url]%"

set _BD_TYPE=%opt[PEMApp.chrome.type]%
call :BUILD_%_BD_TYPE% "%APP_FILE%"
goto :EOF


:BUILD_INST
set "_TmpPath=%_Loc%\Installers\Chrome\"
if exist "%_TmpPath%" goto :EOF
mkdir "%_TmpPath%"
call V2X "%APP_CACHE%" -copy "*_chrome_installer.exe" "%_TmpPath%"
goto :EOF

:BUILD_APP
set "_TmpPath=%_Loc%\PortableApps\Chrome\"
if exist "%_TmpPath%" goto :EOF
call V2X "%APP_CACHE%" -extract "*_chrome_installer.exe" "%_TmpPath%"
7z x -aoa "%_TmpPath%chrome.7z" -o"%_TmpPath%"
del /f "%_TmpPath%chrome.7z"
move /y "%_TmpPath%Chrome-bin" "%_TmpPath%..\"
rd /s /q "%_TmpPath%"
ren "%_Loc%\PortableApps\Chrome-bin" Chrome

if "%opt[material.location]%"=="X:" (
  call LinkToDesktop Chrome.lnk "X:\PEMaterial\PortableApps\Chrome\chrome.exe"
)
goto :EOF
