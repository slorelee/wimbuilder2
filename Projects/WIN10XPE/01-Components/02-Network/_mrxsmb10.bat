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
goto :EOF

:WINSXS_SMB10
echo extracting %1\mrxsmb10.sys
copy /y "%X%\Windows\WinSxS\%1\mrxsmb10.sys" "%X%\Windows\WinSxS\mrxsmb10.sys"
rd /s /q "%X%\Windows\WinSxS\%1"
