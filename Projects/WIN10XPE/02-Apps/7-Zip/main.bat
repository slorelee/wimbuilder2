call V2X 7-Zip -Extract "7z*-%_V_ARCH%.exe" "%X_PF%\7-Zip\"
copy /y 7z-Register.reg "%X_PF%\7-Zip\"

rem call Shortcuts "StartMenu,Desktop,PintTaskbar,PinStartMenu"
rem call LoadShell "X:\Program Files\7-Zip\7z-Register.reg"

