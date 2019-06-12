@echo off
cd /d "%~dp0"
cd ..

if not exist tests\tmp md tests\tmp

echo Replace all "//EXP_"
copy /y tests\Pecmd.ini tests\tmp\Pecmd.ini
call TextReplace tests\tmp\Pecmd.ini #//EXP_ "" g

echo Replace with escape mark
copy /y tests\PecmdAdmin.ini tests\tmp\PecmdAdmin.ini
call TextReplace tests\tmp\PecmdAdmin.ini "DefaultPassword=#q#q" "DefaultDomainName"

echo Replace with escape mark
copy /y tests\PecmdAdmin.ini tests\tmp\PecmdAdmin.ini
call TextReplace tests\tmp\PecmdAdmin.ini "REGI HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultPassword=#q#q" "REGI HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultDomainName"
pause

echo Replace all "Default" to "Admin"
copy /y tests\PecmdAdmin.ini tests\tmp\PecmdAdmin.ini
call TextReplace tests\tmp\PecmdAdmin.ini "Default" "Admin" g
pause

echo Replace *userinit.exe,* line to empty line
copy /y tests\PecmdAdmin.ini tests\tmp\PecmdAdmin.ini
call TextReplace tests\tmp\PecmdAdmin.ini "^.+userinit.exe,.+$" "#r" m
pause

echo Replace *userinit.exe,* line to empty line
copy /y tests\PecmdAdmin.ini tests\tmp\PecmdAdmin.ini
call TextReplace tests\tmp\PecmdAdmin.ini ".*userinit.exe,[^\r]*" "" ""
pause

echo *Remove* *userinit.exe,* line
copy /y tests\PecmdAdmin.ini tests\tmp\PecmdAdmin.ini
call TextReplace tests\tmp\PecmdAdmin.ini ".*userinit.exe,.*#r#n" "" ""
pause

echo Replace all _SUB XXXX to _FUNC XXXX()
copy /y tests\PecmdAdmin.ini tests\tmp\PecmdAdmin.ini
call TextReplace tests\tmp\PecmdAdmin.ini "^_SUB(.+)$" "_FUNC \1()#r" mg
pause

echo Replace all _SUB XXXX to _FUNC XXXX()
copy /y tests\PecmdAdmin.ini tests\tmp\PecmdAdmin.ini
call TextReplace tests\tmp\PecmdAdmin.ini "^_SUB\s([^\r]+)$" "_FUNC $1()" mg
pause


