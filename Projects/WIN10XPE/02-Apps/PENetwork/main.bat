call V2X PENetwork -extract "PENetwork%_V_x64%.7z" "%X_PF%\PENetwork\"
reg import PENetwork_Settings.reg

call LinkToDesktop PENetwork.lnk "#pProgramFiles#p\PENetwork\PENetwork.exe"

del /f /q /a "%X_PF%\PENetwork\*.txt"
if exist "%X_PF%\PENetwork\PENetwork_%WB_PE_LANG%.lng" (
  ren "%X_PF%\PENetwork\PENetwork_%WB_PE_LANG%.lng" "PENetwork_%WB_PE_LANG%.bak"
  del /f /q /a "%X_PF%\PENetwork\*.lng"
  ren "%X_PF%\PENetwork\PENetwork_%WB_PE_LANG%.bak" "PENetwork_%WB_PE_LANG%.lng"
)
