set "_Dir=%PEM.Loc%\Installers\PotPlayer"
if not exist "%_Dir%" goto :EOF
set "f0=%~f0"
call :Requirements "%_Dir%\X"
set _Dir=
goto :EOF

:Requirements
set AddFiles_Mode=batch
call AddFiles "%f0%" :end_files
goto :end_files
@\Windows\System32\
credssp.dll
cryptnet.dll
devenum.dll
dssenh.dll
EhStorAPI.dll
FntCache.dll
jscript9.dll
midimap.dll
msacm32.dll
msdmo.dll
;mshtml.dll
mskeyprotect.dll
OnDemandConnRouteHelper.dll
perfos.dll
policymanager.dll
quartz.dll
rasadhlp.dll
riched32.dll
SensApi.dll
:end_files

if exist "%~1" rd /s /q "%~1"
call DoAddFiles "%~1"

if exist "%_Dir%\Windows.7z" del /f /q "%_Dir%\Windows.7z"
7z a -r "%_Dir%\Windows.7z" "%_Dir%\X\Windows\*"
rd /s /q "%~1"

goto :EOF

