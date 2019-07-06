if exist "%X%\Windows\System32\drivers\mrxsmb10.sys" goto :EOF

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
