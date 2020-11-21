@echo off

rem [Catalog_AddFiles_Info]
rem Use signtool.exe to find Catalogs ex: Signtool verify /kp /v /a X:\Windows\System32\drivers\*.sys > B:\SignDrivers.txt

if "x%opt[build.full_catalog]%"=="xtrue" set opt[build.catalog]=full
if "x%opt[build.full_catalog]%"=="xfalse" set opt[build.catalog]=light

if not "x%opt[build.catalog]%"=="xfull" goto :CATALOG_ADDFILES
rem Full Catalogs
call AddFiles \Windows\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}
goto :EOF

:CATALOG_ADDFILES

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\

Microsoft-Windows-Basic-Http-Minio-Package~*.cat
Microsoft-Windows-DataCenterBridging-Package~*.cat
Microsoft-Windows-DataCenterBridging-Opt-Package*.cat

;built-in network drivers
Microsoft-Windows-Client-Drivers-drivers-Package~*.cat
Microsoft-Windows-Client-Drivers-net-Package~*.cat
Microsoft-Windows-Client-Drivers-Package~*.cat
Microsoft-Windows-Client-Drivers-Package-net~*.cat
Microsoft-Windows-Desktop-Shared-Drivers-*.cat
Microsoft-Client-Features-Classic-WOW64-*.cat

+if "x%opt[slim.extra]%"<>"xtrue"
; For updates
Package_*
-if

; Additions
Microsoft-Windows-Browser-Package~*.cat
Microsoft-Windows-Dedup-ChunkLibrary-Package~*.cat

+ver < 17763
Microsoft-Windows-BusinessScanning-Feature-Package-admin~*.cat
Microsoft-Windows-Common-Modem-Drivers-Package~*.cat
;Microsoft-Windows-SnippingTool-Package~*.cat
Microsoft-Windows-PeerToPeer-Full-Package~*.cat

+if "x%opt[component.wcn]%"="xtrue"
Microsoft-Windows-OneCoreUAP-WCN-Package~*.cat
Microsoft-Windows-OneCoreUAP-WCN-WOW64-Package~*.cat
Microsoft-Windows-WCN-net-Package~*.cat
Microsoft-Windows-WCN-WOW64-net-Package~*.cat
-if

+ver >= 17763
LanguageFeatures-WordBreaking-*.cat
Microsoft-Windows-SecureStartup-Subsystem-base-Package~*.cat

+ver >= 19041
Microsoft-OneCore-IsolatedUserMode-Package*.cat
Microsoft-Windows-EnterpriseClientSync-Host-Opt-Package*.cat

+ver*

+if "x%opt[support.media]%"="xtrue"
Microsoft-OneCore-Multimedia-MFPMP*.cat
Microsoft-Windows-Media-Format-multimedia-Package~*.cat
Microsoft-Windows-Multimedia-RestrictedCodecs-multimedia-Package~*.cat
Microsoft-Windows-Multimedia-RestrictedCodecs-WOW64-multimedia-Package~*.cat
Multimedia-MFCore-Package~*.cat
Multimedia-MFCore-WOW64-Package~*.cat
+ver >= 17763
Multimedia-RestrictedCodecsCore-Package~*.cat
Multimedia-RestrictedCodecsExt-Package~*.cat
+ver*
-if

+if "x%opt[support.photo]%"="xtrue"
Microsoft-Windows-PhotoBasic-Feature-Package~*.cat
+ver >= 17763
Microsoft-Windows-PhotoBasic-PictureTools-Package~*.cat
+ver*
-if

:end_files

