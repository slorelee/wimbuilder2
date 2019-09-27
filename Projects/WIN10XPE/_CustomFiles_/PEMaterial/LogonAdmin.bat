echo Prepare for Administrator ...
del /q X:\Users\Default\NTUSER.DAT
copy /y X:\Windows\System32\config\Default X:\Users\Default\NTUSER.DAT

echo Update registry ...
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

if exist X:\Windows\explorer.exe (
    reg add "%regkey%" /v Shell /d explorer.exe /f
) else (
    reg add "%regkey%" /v Shell /d "X:\Program Files\WinXShell\WinXShell.exe -regist -winpe" /f
)

reg add "%regkey%\SpecialAccounts\UserList" /v Guest /t REG_DWORD /d 0 /f
reg add "%regkey%" /v EnableSIHostIntegration /t REG_DWORD /d 0 /f

rem -- // REGI HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18\ProfileImagePath=X:\Users\Administrator

rem  -- // update NewAdministratorName
if exist X:\Windows\security\templates\unattend.inf (
    echo Update database ...
    secedit.exe /configure /db %WinDir%\security\database\unattend.sdb /cfg %WinDir%\security\templates\unattend.inf /log %WinDir%\security\logs\unattend.log
)

echo Start services ...
rem -- call_dll('Netapi32.dll','NetJoinDomain', nil, 'WORKGROUP', nil, nil, nil, 32)
sc start seclogon

echo Ready to logon ...
tsdiscon.exe
goto :EOF
