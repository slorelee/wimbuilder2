goto :main
Title=Accessibility
Type=XPEPlugin
Description=Ease of Access, Magnify, OnScreenKeybord in addition to narrator
Author=ChriSR
Date=2018.05.30

:main
rem ==========update filesystem==========
call AddFiles %0 :end_files
goto :end_files

; shortcuts
\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessibility\

@windows\system32\

; In Common Osk Paint Wordpad
IconCodecService.dll,UIRibbonRes.dll
;WindowsCodecs.dll already in winre.wim
WindowsCodecsExt.dll

; mfc42u.dll already in winre.wim
UIRibbon.dll

; Osk
osk.exe,utilman.exe,OskSupport.dll

; Ease of Access
accessibilitycpl.dll,Magnification.dll,Magnify.exe,PlaySndSrv.dll,sethc.exe
;Windows.Media.Speech.dll
Windows.Internal.Shell.Broker.dll,Windows.Perception.Stub.dll,Windows.UI.dll

:end_files

