call V2X PENetwork -extract "PENetwork%_V_x64%.7z" "%X_PF%\PENetwork\"
reg import PENetwork_Settings.reg

call LinkToDesktop PENetwork.lnk "#pProgramFiles#p\PENetwork\PENetwork.exe"
