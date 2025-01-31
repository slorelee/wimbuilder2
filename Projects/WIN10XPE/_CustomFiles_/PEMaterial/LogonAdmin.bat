echo Prepare for Administrator ...
del /q X:\Users\Default\NTUSER.DAT
copy /y X:\Windows\System32\config\Default X:\Users\Default\NTUSER.DAT

echo Update registry ...

rem show logon animation
reg delete "HKLM\DEFAULT\Control Panel\Desktop" /v "UserPreferencesMask" /f

set "regkey=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
reg add "%regkey%" /v AutoAdminLogon /t REG_DWORD /d 1 /f
reg add "%regkey%" /v DefaultUserName /d Administrator /f
reg add "%regkey%" /v DefaultPassword /d "" /f

if "x%~1"=="xLUA" (
  reg add "%regkey%" /v Userinit /d "userinit.exe,X:\Program Files\WinXShell\WinXShell.exe -script %PECMD_SCRIPT% -user Administrator" /f
) else if "x%~1"=="xPECMD" (
  reg add "%regkey%" /v Userinit /d "userinit.exe,Pecmd.exe MAIN -user %Windir%\System32\pecmd.ini" /f
) else (
  reg add "%regkey%" /v Userinit /d "userinit.exe,X:\Windows\System32\startnet.cmd -init ADMIN" /f
)

if not exist X:\Windows\explorer.exe (
    reg add "%regkey%" /v Shell /d "X:\Program Files\WinXShell\WinXShell.exe -regist -winpe" /f
)

reg add "%regkey%\SpecialAccounts\UserList" /v Guest /t REG_DWORD /d 0 /f

if exist X:\Windows\System32\AppxSysprep.dll (
    reg add "%regkey%" /v EnableSIHostIntegration /t REG_DWORD /d 1 /f
) else (
    reg add "%regkey%" /v EnableSIHostIntegration /t REG_DWORD /d 0 /f
)

rem -- // REGI HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18\ProfileImagePath=X:\Users\Administrator

rem  -- // update NewAdministratorName
if exist X:\Windows\security\templates\unattend.inf (
    echo Update database ...
    secedit.exe /configure /db %WinDir%\security\database\unattend.sdb /cfg %WinDir%\security\templates\unattend.inf /log %WinDir%\security\logs\unattend.log
)

echo Start services ...
sc start seclogon

if exist "%WinDir%\System32\PreCreateAdminProfile.bat" call PreCreateAdminProfile.bat

if exist X:\Windows\System32\AppxSysprep.dll (
     reg add HKEY_LOCAL_MACHINE\SYSTEM\Setup /v SystemSetupInProgress /t REG_DWORD /d 0 /f
     sc start SENS
     sc start CoreMessagingRegistrar
     sc start UserManager
     sc start BrokerInfrastructure
     sc start StateRepository
     sc start Schedule
     sc start AppReadiness
     rem sc stop DsmSvc
     rem classic contextmenu
     rem reg delete "HKLM\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /va /f
)
start /wait "System Init" "X:\Program Files\WinXShell\WinXShell.exe" -code WinPE:SystemInit()
start /wait "NetJoin" "X:\Program Files\WinXShell\WinXShell.exe" -code System:NetJoin('WORKGROUP')

echo Ready to logon ...
tsdiscon.exe
goto :EOF
