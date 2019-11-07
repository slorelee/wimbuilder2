Set objShellApp = CreateObject("Shell.Application")
If Wscript.Arguments.Count > 0 Then
  p = ""
  If Wscript.Arguments.Count > 1 Then p = GetArguments(Wscript.Arguments)
  objShellApp.ShellExecute Wscript.Arguments(0), p, "", "runas", 1
End If

Function GetArguments(objArgs)
    Dim s, i
    s = ""
    For i = 1 To objArgs.Count - 1
        If InStr(1, objArgs(i), " ") > 0 Then
            s = s & """" & objArgs(i) & """ "
        Else
            s = s & objArgs(i) & " "
        End If
    Next
    GetArguments = s
End Function
