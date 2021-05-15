
if %VER[3]% LSS 18300 goto :UpdateNewMenu

if %VER[3]% GTR 20000 (
  reg add HKLM\Tmp_Software\Classes\.txt\ShellNew /v NullFile /f
  if "x%opt[build.registry.software]%"=="xfull" (
    reg import NotepadAssoc.txt
  )
)
goto :EOF

:UpdateNewMenu
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew /v Classes /t REG_MULTI_SZ /d .library-ms\0.txt\0Folder /f
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew /v ~reserved~ /t REG_BINARY /d 0800000000000600 /f
