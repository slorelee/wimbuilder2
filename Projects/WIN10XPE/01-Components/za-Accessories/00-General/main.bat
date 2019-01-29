set "f0=%~f0"
if "x%opt[component.mspaint]%"=="xtrue" call :add_mspaint
if "x%opt[component.winphotoview]%"=="xtrue" call :add_winphotoview
set f0=
goto :EOF

:add_mspaint
call AddFiles "%f0%" :end_mspaint_files
goto :end_mspaint_files
@\Windows\system32\
+mui
mspaint.exe
:end_mspaint_files
goto :EOF

:add_winphotoview
call AddFiles "%f0%" :end_winphotoview_files
goto :end_winphotoview_files
\Program Files\Windows Photo Viewer\
;only needs spool\drivers, but add all because it very small
\Windows\System32\spool
@\Windows\system32\
coloradapterclient.dll,efswrt.dll,icm32.dll,mscms.dll
+mui
photowiz.dll,shimgvw.dll
:end_winphotoview_files

call RegCopy HKLM\SOFTWARE\Classes\PhotoViewer.FileAssoc.Tiff
for %%i in (.bmp .jpg .jpeg .png .gif .jfif .tif .tiff) do call :_add_winphotoview_assoc_reg %%i
goto :EOF

:_add_winphotoview_assoc_reg
reg add HKLM\tmp_DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%1\UserChoice /v Hash /d 7vFx3a4+MGg= /f
reg add HKLM\tmp_DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%1\UserChoice /v ProgId /d PhotoViewer.FileAssoc.Tiff /f
reg add "HKLM\tmp_SOFTWARE\Classes\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v %1 /d PhotoViewer.FileAssoc.Tiff /f
goto :EOF
