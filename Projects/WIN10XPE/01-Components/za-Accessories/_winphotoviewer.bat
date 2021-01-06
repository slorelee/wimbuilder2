call AddFiles %0 :end_files
goto :end_files
\Program Files\Windows Photo Viewer\
\Windows\System32\spool\drivers\color\
@\Windows\system32\
coloradapterclient.dll,efswrt.dll,icm32.dll,mscms.dll,photowiz.dll,shimgvw.dll
:end_files

call RegCopy HKLM\SOFTWARE\Classes\PhotoViewer.FileAssoc.Tiff
for %%i in (.bmp .jpg .jpeg .png .gif .jfif .tif .tiff) do call :_add_winphotoviewer_assoc_reg %%i
goto :EOF

:_add_winphotoviewer_assoc_reg
reg add HKLM\tmp_DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%1\UserChoice /v Hash /d 7vFx3a4+MGg= /f
reg add HKLM\tmp_DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%1\UserChoice /v ProgId /d PhotoViewer.FileAssoc.Tiff /f
reg add "HKLM\tmp_SOFTWARE\Classes\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v %1 /d PhotoViewer.FileAssoc.Tiff /f
goto :EOF

