rem Patch Windows.UI.CredDialogController.dll to use the Credentials Window than Credentials  Console
rem M.i.n.i.N.T => N.i.n.i.N.T
binmay.exe -u "%X_SYS%\Windows.UI.CredDialogController.dll" -s u:MiniNT -r u:NiniNT
fc /b "%X_SYS%\Windows.UI.CredDialogController.dll.org" "%X_SYS%\Windows.UI.CredDialogController.dll"
del /q "%X_SYS%\Windows.UI.CredDialogController.dll.org"
