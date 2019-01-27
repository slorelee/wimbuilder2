@echo off

if not "x%opt[build.catalog]%"=="xfull" goto :CATALOG_ADDFILES

call AddFiles %0 :end_full_files
goto :end_full_files

;[Catalog_AddFiles_Info]
; Full Catalogs: \Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}
; Use signtool.exe to find Catalogs ex: Signtool verify /kp /v /a X:\Windows\System32\drivers\*.sys > B:\SignDrivers.txt

\Windows\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}
:end_full_files
goto :EOF

:CATALOG_ADDFILES
call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\

+ver < 17763
Microsoft-Windows-Basic-Http-Minio-Package~*.cat
Microsoft-Windows-Client-Drivers-drivers-Package~*.cat
Microsoft-Windows-Client-Drivers-net-Package~*.cat
Microsoft-Windows-Client-Drivers-Package~*.cat
Microsoft-Windows-Client-Drivers-Package-net~*.cat
Microsoft-Windows-Client-Features-Package*.cat
Microsoft-Windows-Desktop-Shared-Drivers-*.cat
Microsoft-Windows-DataCenterBridging-Package~*.cat
Microsoft-Windows-SMB1-Package~*.cat
Microsoft-Client-Features-Classic-WOW64-*.cat
Microsoft-Windows-Client-Features-WOW64-Package*.cat
; For updates
Package_*
; Additions
Microsoft-Windows-Browser-Package~*.cat
Microsoft-Windows-BusinessScanning-Feature-Package-admin~*.cat
Microsoft-Windows-Common-Modem-Drivers-Package~*.cat
Microsoft-Windows-Dedup-ChunkLibrary-Package~*.cat
Microsoft-Windows-InternetExplorer-inetcore-Package~*.cat
Microsoft-Windows-InternetExplorer-onecoreuap-Package~*.cat
Microsoft-Windows-NetFx4-US-OC-Package~*.cat
Microsoft-Windows-Media-Format-multimedia-Package~*.cat
Microsoft-Windows-Multimedia-RestrictedCodecs-multimedia-Package~*.cat
Microsoft-Windows-OneCoreUAP-WCN-Package~*.cat
Microsoft-Windows-OneCoreUAP-WCN-WOW64-Package~*.cat
Microsoft-Windows-PeerToPeer-Full-Package~*.cat
Microsoft-Windows-PhotoBasic-Feature-Package~*.cat
Microsoft-Windows-RemoteDesktop-*.cat
Microsoft-Windows-SearchEngine-Client-Package~*.cat
Microsoft-Windows-SnippingTool-Package~*.cat
Microsoft-Windows-WCN-net-Package~*.cat
Microsoft-Windows-WCN-WOW64-net-Package~*.cat
Multimedia-MFCore-Package~*.cat
Multimedia-MFCore-WOW64-Package~*.cat
Multimedia-RestrictedCodecsCore-Package~*.cat
Multimedia-RestrictedCodecsExt-Package~*.cat

+ver >= 17763
; typo? this line make all catalog ?
\Windows\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}

;skip
+ver = 0
Microsoft-Windows-Client-Desktop-Required-Package*.cat
Microsoft-Windows-Client-Desktop-Required-WOW64-Package*.cat
Microsoft-Windows-Client-Features-Package*.cat
Microsoft-Windows-Client-Features-WOW64-Package*.cat
Microsoft-Windows-Basic-Http-Minio-Package~*.cat
Microsoft-Windows-DataCenterBridging-Package~*.cat
Microsoft-Windows-SMB1-Package~*.cat
; Additions
LanguageFeatures-WordBreaking-*.cat
Microsoft-Windows-Browser-Package~*.cat
Microsoft-Windows-Dedup-ChunkLibrary-Package~*.cat
Microsoft-Windows-Media-Format-multimedia-Package~*.cat
Microsoft-Windows-Multimedia-RestrictedCodecs-multimedia-Package~*.cat
Microsoft-Windows-Multimedia-RestrictedCodecs-WOW64-multimedia-Package~*.cat
Microsoft-Windows-NetFx4-US-OC-Package~*.cat
Microsoft-Windows-NetFx-Shared-Package~*.cat
Microsoft-Windows-PhotoBasic-Feature-Package~*.cat
Microsoft-Windows-PhotoBasic-PictureTools-Package~*.cat
Microsoft-Windows-SearchEngine-Client-Package~*.cat
Microsoft-Windows-SecureStartup-Subsystem-base-Package~*.cat
Microsoft-Windows-TerminalServices-CommandLineTools-Package~*.cat
Microsoft-Windows-WPD-UltimatePortableDeviceFeature-Feature-Package~*.cat
Multimedia-MFCore-Package~*.cat
Multimedia-MFCore-WOW64-Package~*.cat
Multimedia-RestrictedCodecsCore-Package~*.cat
Multimedia-RestrictedCodecsExt-Package~*.cat
WindowsSearchEngineSKU-Group-Package~*.cat


:end_files

