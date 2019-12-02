rem ==========update filesystem==========

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\
comctl32.dll
ExplorerFrame.dll

; File(s)/Folder(s)/RecyleBin property
+ver < 16299
actxprxy.dll
apphelp.dll
+ver*

;"Security" tab
rshx32.dll

;"Security" tab - change Owner
;comsvcs.dll

+ver > 17700
; shellstyle.dll(.mui) is now in \Windows\resources\themes\aero\shell\normalcolor
\Windows\resources\Themes\aero\shell
+ver <= 17700 or (ver > 18334 and ver < 18800) or ver > 18836
shellstyle.dll
en-US\shellstyle.dll.mui
+ver*

; DragAndDrop (d2d1.dll,ksuser.dll already in Winre.wim)
DataExchange.dll,dcomp.dll,d3d11.dll,dxgi.dll
;d2d1.dll,ksuser.dll

; CopyProgress
chartv.dll,OneCoreUAPCommonProxyStub.dll

; Overwrite confirmation dialog
actxprxy.dll

;filter
StructuredQuery.dll

:end_files

rem ;For "Security" tab (rshx32.dll)
reg add HKLM\Tmp_SOFTWARE\Classes\*\shellex\PropertySheetHandlers\{1f2e5c40-9550-11ce-99d2-00aa006e086c} /f
reg add HKLM\Tmp_SOFTWARE\Classes\Directory\shellex\PropertySheetHandlers\{1f2e5c40-9550-11ce-99d2-00aa006e086c} /f
rem reg add HKLM\Tmp_SOFTWARE\Classes\Drive\shellex\PropertySheetHandlers\{1f2e5c40-9550-11ce-99d2-00aa006e086c}] /f

rem ;For "Security" tab - change Owner
reg add HKLM\Tmp_SOFTWARE\Classes\new /ve /d "New Moniker" /f
reg add HKLM\Tmp_SOFTWARE\Classes\new\CLSID /ve /d "{ecabafc6-7f19-11d2-978e-0000f8757e2a}" /f

goto :EOF

rem explorerframe.dll CLSID
rem HKLM\SOFTWARE\Classes\CLSID\{056440FD-8568-48e7-A632-72157243B55B} required
rem already added by RegCopy HKLM\SOFTWARE\Classes\CLSID

rem reg import FileProperty.reg
