echo 可以使用wimlib命令，对WB_BASE_PATH文件进行预处理，
echo 比如精简文件，添加替换文件和注册表。
sleep 1
rem set WB_

rem 使用白名单精简
if not exist "SysWhiteList.txt" goto :EOF
pushd "%~dp0"
wimlib-imagex dir "%WB_BASE_PATH%" %WB_BASE_INDEX% --path=\Windows\System32\ > _wimsyslist.txt
echo %time%
call UpdateWimWithWhiteList.vbs
wimlib-imagex update "%WB_BASE_PATH%" %WB_BASE_INDEX% < _wimsyslist.txt
popd
echo %time%


goto :EOF



:SAMPLE_INFO
WB_ROOT=E:\WimBuilder2
WB_HOST_LANG=zh-CN
WB_ARCH=x64

WB_PROJECT=WIN10XPE
WB_PROJECT_PATH=E:\WimBuilder2\Projects\WIN10XPE

WB_SRC=H:\sources\install.wim
WB_SRC_FOLDER=H:
WB_SRC_INDEX=1

WB_BASE=winre.wim
WB_BASE_PATH=Z:\WimBuilder2\_Factory_\target\WIN10XPE\winre.wim
WB_BASE_INDEX=1

WB_PE_ARCH=x64
WB_PE_BUILD=1
WB_PE_LANG=zh-CN
WB_PE_VER=10.0.21390


WB_TMP_PATH=Z:\WimBuilder2\_Factory_\tmp\WIN10XPE
WB_USER_PROJECT_PATH=E:\WimBuilder2\AppData.link\Projects\WIN10XPE
WB_X_DRIVE=X:
goto :EOF
