@echo off
set _Vx86amd64=amd64
if "%WB_PE_ARCH%"=="x86" set _Vx86amd64=x86
call V2X VBoxGuestAdditions -extract "%opt[vbox.version]%_vboxguest.inf_%_Vx86amd64%.7z" "%X_WIN%\Temp\vboxguest.inf\"
copy /y InstVBoxGuestAdditions.bat "%X_Startup%\"
