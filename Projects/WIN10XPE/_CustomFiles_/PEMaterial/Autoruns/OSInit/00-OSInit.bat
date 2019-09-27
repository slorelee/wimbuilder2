rem // Hide start menu Startup folders
attrib.exe +s +h "X:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"

rem // LetterSwap
rem LetterSwap.exe /auto /bootdrive Y:\CDUsb.y /Log %WinDir%\System32\LetterSwap.log

rem // Load oem drivers before shell in background
rem pnputil.exe /add-driver %WinDir%\inf\oem*.inf

