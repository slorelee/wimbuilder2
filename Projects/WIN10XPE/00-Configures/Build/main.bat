@echo off

call ACLRegKey Tmp_System
call ACLRegKey Tmp_Software
call ACLRegKey Tmp_Default
rem call ACLRegKey Tmp_Drivers

call RegCopy HKLM\Software\Classes\AppID
call ACLRegKey HKLM\Software\Classes\AppID

rem set "RunAs"="Interactive User" -* "RunAs"=""
for /F %%i IN ('Reg Query HKLM\Tmp_Software\Classes\AppID /s /f "Interactive User" ^|Findstr Tmp_Software') do (
  Reg Add "%%i" /v RunAs /d "" /F >nul 2>nul
)

call RegCopy HKLM\Software\Classes\CLSID
call RegCopy HKLM\Software\Classes\Interface
call RegCopy HKLM\Software\Classes\TypeLib
call RegCopy HKLM\Software\Classes\Folder
call RegCopy HKLM\Software\Classes\themefile
call RegCopy HKLM\Software\Classes\SystemFileAssociations
call RegCopy "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Svchost"
call RegCopy HKLM\Software\Microsoft\SecurityManager
call RegCopy HKLM\Software\Microsoft\Ole

rem policymanager.dll need:
call RegCopy HKLM\Software\Microsoft\PolicyManager
rem call RegCopy HKLM\Software\Classes\Unknown

call "%~dp0Catalog.bat"
