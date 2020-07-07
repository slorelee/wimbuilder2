======================================================================================================
2020-06-08 18:00 bfgxp

dism组件必须文件
wdscore.dll

GUI界面必须文件
TextShaping.dll

GUI浏览必须文件
wldp.dll

explorer++必须文件
dui70.dll

关机重启必须文件
wpeutil.exe

diskgen必须文件
oleacc.dll
oledlg.dll

dism离线集成驱动必须文件
drvstore.dll

分区助手PE版必须文件（explorer++最新的Beta版也需要这两个文件）
iertutil.dll
urlmon.dll

regsvr32必须文件
regapi.dll

wpeinit必须文件
dnsapi.dll
odbc32.dll

粘贴文件必须文件(WinXShell必须以参数-winpe运行）
difxapi.dll
shdocvw.dll
Windows.FileExplorer.Common

======================================================================================================
2020-06-19 18:17 sairen139

aclui.dll必须存在（删掉打不开regedit）

C_936必须存在（删掉不能进桌面）

msxml3.dll必须存在（删掉可以进桌面但打不开第三方资源管理器explorer++）

wimgapi.dll必须存在（删掉打不开winNTsetup64.exe）

======================================================================================================
2020-06-21 07:06 bfgxp

UI界面文字需要TextShaping.dll
    开始菜单文字消失，只有图标 < sairen139

======================================================================================================
2020-06-24 19:09 sairen139

增加explorer++文件浏览器需要依赖的dll如下：
\Windows\System32\msxml3.dll
\Windows\System32\msxml3r.dll  
\Windows\System32\version.dll

增添复制粘贴功能explorer++需要依赖的dll文件如下：  
\Windows\System32\dui70.dll
\Windows\System32\ntmarta.dll  
\Windows\System32\Windows.FileExplorer.Common.dll

======================================================================================================
2020-06-26 14:00 bfgxp

拖拽文件必须文件
d3d11.dll/dcomp.dll/dxgi.dll/StructuredQuery.dll/actxprxy.dll/DataExchange.dll/scecli.dll/comctl32.dll
======================================================================================================
2020-06-26 14:00 bfgxp

添加触摸支持文件ninput.dll

======================================================================================================
2020-07-04 18:00 bfgxp

解决覆盖文件错误提示的问题，需要一个14M的shell32.dll.mun（覆盖提示对话框需要）
及comctl32.dll与shellstyle.dll（没有它会提示内存不足）

采用立帮电子的精简shell32.dll.mun
