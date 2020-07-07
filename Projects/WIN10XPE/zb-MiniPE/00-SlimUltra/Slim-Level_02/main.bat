if "x%SlimUtra2_LV02%"=="xdone" goto :EOF
set SlimUtra2_LV02=done

echo Extra-Sliming...

rem wpeutil.exe can't run
del /a /f /q "%X_PEMaterial%\Autoruns\Startup\InitializeNetwork.bat"

del /a /f /q "%X_WIN%\SystemResources\aclui.dll.mun"
del /a /f /q "%X_WIN%\SystemResources\comdlg32.dll.mun"
del /a /f /q "%X_WIN%\SystemResources\crypt32.dll.mun"
del /a /f /q "%X_WIN%\SystemResources\msxml3.dll.mun"
del /a /f /q "%X_WIN%\SystemResources\ntshrui.dll.mun"
del /a /f /q "%X_WIN%\SystemResources\shell32.dll.mun"

call :KEEP_FILE \Windows\Fonts\simsun.ttc
del /a /f /q "%X_WIN%\Fonts\*.*"

del /a /f /q "%X_SYS%\config\COMPONENTS"

call :DEL_SYSFILES "activeds.dll,asycfilt.dll,cabinet.dll,chartv.dll,chkntfs.exe,cnvfat.dll,comctl32.dll,compact.exe"
call :DEL_SYSFILES "console.dll,d3d11.dll,DataExchange.dll,dbgcore.dll,dcomp.dll,dfscli.dll,dnsapi.dll"
rem call :DEL_SYSFILES "dsparse.dll,dsrole.dll,dxgi.dll,ExplorerFrame.dll,feclient.dll,fms.dll,gpapi.dll"
rem explorer.exe dxgi.dll
call :DEL_SYSFILES "dsparse.dll,dsrole.dll,feclient.dll,fms.dll,gpapi.dll"
call :DEL_SYSFILES "input.dll,logoncli.dll,msIso.dll,msls31.dll,msports.dll,msxml6r.dll,mycomput.dll"
call :DEL_SYSFILES "netprovfw.dll,nsisvc.dll,odbc32.dll,regapi.dll,scecli.dll,schema.dat,shellstyle.dll,shutdownux.dll"
call :DEL_SYSFILES "slc.dll,sppc.dll,sti.dll,Storprop.dll,StructuredQuery.dll,sysclass.dll,tdh.dll"
call :DEL_SYSFILES "umpo.dll,umpoext.dll,uReFs.dll,uReFSv1.dll,usermgrcli.dll,usp10.dll,utildll.dll,winnsi.dll,wkssvc.dll,wmsgapi.dll"

:END_SLIM_FILES
rem restore [KEEP]
if not exist "%X%\[KEEP]" goto :EOF
xcopy /S /E /Q /H /K /Y "%X%\[KEEP]" "%X%\"
rd /s /q "%X%\[KEEP]"
goto :EOF

:DEL_FONTS
for %%i in (%~1) do (
  del /a /f /q "%X_WIN%\Fonts\%%i%~2"
)
goto :EOF

:DEL_DRIVERS
for %%i in (%~1) do (
  del /a /f /q "%X_SYS%\Drivers\%%i"
)
goto :EOF

:DEL_DRVSTORES
for %%i in (%~1) do (
  call :DEL_DRVSTORE "%%i"
)
goto :EOF

:DEL_DRVSTORE
for /f "delims=" %%i in ('dir /b /ad "%X_SYS%\DriverStore\FileRepository\%~1*"') do (
  echo rd /s /q "%X_SYS%\DriverStore\FileRepository\%%i"
  rd /s /q "%X_SYS%\DriverStore\FileRepository\%%i"
)
del /a /f /q "%X_WIN%\Inf\%~1.inf"
del /a /f /q "%X_SYS%\DriverStore\%WB_PE_LANG%\%~1.inf_loc"
goto :EOF

:DEL_SYSFILES
for %%i in (%~1) do (
  del /a /f /q "%X_SYS%\%%i"
)
goto :EOF


:KEEP_FILES
echo move "%~1%~2" "%X%\[KEEP]%~1"
if not exist "%X%\[KEEP]%~1" mkdir "%X%\[KEEP]%~1"
for %%i in (%~2) do (
  move "%X%%~1%%i" "%X%\[KEEP]%~1"
)
goto :EOF

:KEEP_FILE
echo move "%~1" "%X%\[KEEP]%~p1"
if not exist "%X%\[KEEP]%~p1" mkdir "%X%\[KEEP]%~p1"
move "%X%%~1" "%X%\[KEEP]%~1"
goto :EOF
