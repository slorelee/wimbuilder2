if exist "%X%\Windows\System32\drivers\mrxsmb10.sys" goto :EOF

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
Microsoft-Windows-SMB1Client-D-Opt-Package~*.cat
Microsoft-Windows-SMB1Deprecation-Group-Package~*.cat
Microsoft-Windows-SMB1-Package~*.cat
Microsoft-Windows-SMB1Server-D-Opt-Package~*.cat
:end_files

rem Extract mrxsmb10.sys from WinSxS
call AddFiles "\Windows\WinSxS\*_microsoft-windows-smb10-minirdr_*\mrxsmb10.sys"

for /f "delims=" %%i in ('dir /b "%X%\Windows\WinSxS\*_microsoft-windows-smb10-minirdr_*"') do (
  call :WINSXS_SMB10 %%i
)

rem D.C.S. or M.Z.
rem copy /y "%X%\Windows\WinSxS\mrxsmb10.sys" "%X_SYS%\drivers\mrxsmb10.sys"
rem sxsexp32 must run in Windows 10(build host)

if %WB_ARCH%==x64 (
  sxsexp64.exe "%X%\Windows\WinSxS\mrxsmb10.sys" "%X_SYS%\drivers\mrxsmb10.sys"
) else (
  sxsexp32.exe "%X%\Windows\WinSxS\mrxsmb10.sys" "%X_SYS%\drivers\mrxsmb10.sys"
)

del /f /q "%X%\Windows\WinSxS\mrxsmb10.sys"
if exist "%X%\Windows\System32\drivers\mrxsmb10.sys" (
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v DependOnService /t REG_MULTI_SZ /d mrxsmb /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v Description /d "@%%systemroot%%\system32\wkssvc.dll,-1005" /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v DisplayName /d "@%%systemroot%%\system32\wkssvc.dll,-1004" /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v ErrorControl /t REG_DWORD /d 1 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v Group /d Network /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v ImagePath /t REG_EXPAND_SZ /d system32\DRIVERS\mrxsmb10.sys /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v Start /t REG_DWORD /d 2 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v Tag /t REG_DWORD /d 6 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v Type /t REG_DWORD /d 2 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\LanmanWorkstation /v DependOnService /t REG_MULTI_SZ /d Bowser\0MRxSmb10\0MRxSmb20\0NSI /f
)
goto :EOF

:WINSXS_SMB10
echo extracting %1\mrxsmb10.sys
copy /y "%X%\Windows\WinSxS\%1\mrxsmb10.sys" "%X%\Windows\WinSxS\mrxsmb10.sys"
rd /s /q "%X%\Windows\WinSxS\%1"
