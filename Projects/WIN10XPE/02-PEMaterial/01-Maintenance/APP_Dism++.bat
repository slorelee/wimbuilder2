call V2X "%APP_CACHE%" -extract "Dism*.zip" "%X_PF%\Dism++\"
call LinkToDesktop Dism++镜像工具.lnk "#pProgramFiles#p\Dism++\Dism++%_Vx8664%.exe"
call LinkToStartMenu "镜像制作\Dism++.lnk" "#pProgramFiles#p\Dism++\Dism++%_Vx8664%.exe"