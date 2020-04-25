call AddFiles %0 :end_files
goto :end_files

\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk

@\Program Files\Common Files\Microsoft Shared\ink\
InkObj.dll,tpcps.dll
??-??\InkObj.dll.mui

@\Windows\system32\
SnippingTool.exe
DWrite.dll,msdrm.dll,oleacc.dll,oleaccrc.dll,uxtheme.dll,wisp.dll
:end_files

rem call LinkToStartMenu "Accessories\#{@SnippingTool.exe,101}.lnk" SnippingTool.exe

