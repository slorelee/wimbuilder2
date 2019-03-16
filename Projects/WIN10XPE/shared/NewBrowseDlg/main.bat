rem ==========update filesystem==========

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\
comctl32.dll
ExplorerFrame.dll

+ver > 17700
; shellstyle.dll(.mui) is now in \Windows\resources\themes\aero\shell\normalcolor
\Windows\resources\Themes\aero\shell
+ver <= 17700
shellstyle.dll
+ver*

; DragAndDrop (d2d1.dll,ksuser.dll already in Winre.wim)
DataExchange.dll,dcomp.dll,d3d11.dll,dxgi.dll
;d2d1.dll,ksuser.dll

; CopyProgress
chartv.dll,OneCoreUAPCommonProxyStub.dll

:end_files
goto :EOF

rem explorerframe.dll CLSID
rem HKLM\SOFTWARE\Classes\CLSID\{056440FD-8568-48e7-A632-72157243B55B} required
rem already added by RegCopy HKLM\SOFTWARE\Classes\CLSID