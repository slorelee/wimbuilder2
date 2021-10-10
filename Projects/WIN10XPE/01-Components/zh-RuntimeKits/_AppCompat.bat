call AddFiles %0 :[WindowsCompatibility_Files]
call :[WindowsCompatibility_RegItems]
goto :EOF


:[WindowsCompatibility_Files]
@\Windows\System32\

drivers\ahcache.sys

;catalog file for ahcache.sys
%CatRoot%\Microsoft-Windows-Client-Desktop-Required-Package0418~*~amd64~~*.*.*.*.cat

+syswow64
appraiser.dll,acmigration.dll
AcSpecfc.dll,AcWinRT.dll,AcXtrnal.dll
MirrorDrvCompat.dll,Win32CompatibilityAppraiserCSP.dll,wmdrmsdk.dll
AcGenral.dll,AcLayers.dll,acppage.dll,aepic.dll
apphelp.dll,Apphlpdm.dll,AppResolver.dll,cscapi.dll,dlnashext.dll
sdbinst.exe,sfc.dll,sfc_os.dll,shdocvw.dll

+if "x%opt[appcompat.assistant]%"="xtrue"
;Program Compatibility Assistant
pcacli.dll,pcadm.dll,pcaevts.dll,pcalua.exe,pcasvc.dll,pcaui.dll,pcaui.exe
apisampling.dll,pcwutl.dll
-if

goto :EOF

:[WindowsCompatibility_RegItems]
call RegCopy "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags"
call RegCopyEx Services "ahcache,PcaSvc"
if not "x%opt[appcompat.assistant]%"=="xtrue" (
    reg add HKLM\Tmp_System\ControlSet001\Services\PcaSvc /v Start /t REG_DWORD /d 4 /f
    reg add HKLM\Tmp_System\ControlSet001\Services\PcaSvc /v "Description" /d "PcaSvc" /f
)

call RegCopyEx Classes "CompatContextMenu.CompatContextMenu,CompatContextMenu.CompatContextMenu.1"

for %%i in (batfile,cmdfile,exefile,lnkfile,Msi.Package,piffile) do (
    call RegCopyEx Classes "%%i\shellex\PropertySheetHandlers"
)

goto :EOF


