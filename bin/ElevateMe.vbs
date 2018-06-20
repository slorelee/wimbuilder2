Set objShellApp = CreateObject("Shell.Application")
If Wscript.Arguments.Count > 0 Then
  p = ""
  If Wscript.Arguments.Count > 1 Then p = Wscript.Arguments(1)
  objShellApp.ShellExecute Wscript.Arguments(0), p, "", "runas", 1
End If
