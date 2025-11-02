rem hide the version watermark on Desktop
reg add "HKLM\Tmp_Default\Control Panel\Desktop" /v PaintDesktopVersion /t REG_DWORD /d 0 /f
