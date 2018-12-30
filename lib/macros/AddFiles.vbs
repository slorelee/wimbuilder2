Set objArgs = WScript.Arguments
If objArgs.Count < 2 Then
    WScript.Echo "AddFiles.vbs:Wrong Parmaters."
    WScript.Quit(1)
End If

'For i = 0 To objArgs.Count - 1
'   WScript.Echo "ARGUMENTS(" & i & "):" & objArgs.Item(i)
'Next

Dim g_path, g_mui, g_mui_list, g_ver

Dim code_file, code_word, out_file

If objArgs.Count = 2 Then
  code_file = ""
  code_word = objArgs.Item(0)
  out_file = objArgs.Item(1)
Else
  code_file = objArgs.Item(0)
  code_word = objArgs.Item(1)
  out_file = objArgs.Item(2)
End If

Dim fso
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Const TristateFalse = 0

Set fso = CreateObject("Scripting.FileSystemObject")

Dim wshShell, env, wim_ver
Set wshShell = WScript.CreateObject("WScript.Shell")
Set env = wshShell.Environment("Process")
wim_ver = env("WB_PE_VER")

Dim f, bCode, line
Dim outs
outs = ""

If code_file <> "" Then
  Set f = fso.OpenTextFile(code_file, ForReading, False)
  line = f.Readline
  Do Until f.AtEndOfStream
     line = f.ReadLine
     If (Not bCode) And line = "goto " & code_word Then
         bCode = true
     ElseIf line = code_word Then
         Exit Do
     ElseIf bCode Then
         parser(line)
     End If
  Loop
  f.Close
Else
  outs = code_word
End If

WSH.echo outs
Set f = fso.OpenTextFile(out_file, ForAppending, True)
f.Write outs
f.Close

Function check_ver(ver_line)
  If ver_line = "pass" Or ver_line = "skip" Then
    check_ver = ver_line
    Exit Function
  End If

  Dim build_num
  build_num = Split(wim_ver, ".")(2)
  ver_line = Mid(ver_line, 2)
  ver_line = Replace(ver_line, "ver", build_num)
  check_ver = "skip"
  If eval(ver_line) Then check_ver = "pass"
End Function

Sub parser(line)
  If line = "" Then Exit Sub             'empty line
  If Left(line, 1) = ";" Then Exit Sub   'comment line

  If line = "@-" Then g_path = "":Exit Sub
  If Left(line, 1) = "@" Then
    g_path = Mid(line, 2)
    If Left(g_path, 1) <> "\" Then g_path = "\" & g_path
    If Right(g_path, 1) <> "\" Then g_path = g_path & "\"
    'expand environment variables in string
    If InStr(g_path, "%") > 0 Then
      g_path = wshShell.ExpandEnvironmentStrings(g_path)
    End If
    Exit Sub
  End If

  If line = "-mui" Then
    g_mui = ""
    Exit Sub
  ElseIf line = "+mui" Then
    g_mui = "+"
    g_mui_list = "??-??"
    Exit Sub
  ElseIf Left(line, 4) = "+mui" Then
    g_mui = "+"
    g_mui_list = Mid(line, 6, Len(line) - 6)
    If InStr(g_mui_list, "%") > 0 Then
      g_mui_list = wshShell.ExpandEnvironmentStrings(g_mui_list)
    End If
    Exit Sub
  End If

  If Left(line, 5) = "+ver*" Then g_ver = "":Exit Sub
  If Left(line, 4) = "+ver" Then g_ver = line:Exit Sub

  If g_ver <> "" Then
    g_ver = check_ver(g_ver)
    If g_ver = "skip" Then Exit Sub
  End If

  Dim i, files
  files = Split(line, ",")
  For i = 0 To Ubound(files)
      addfile(files(i))
  Next
End Sub

Sub addfile(fn)
  Dim i, ext, mui_arr

  If InStr(fn, "%") > 0 Then
    fn = wshShell.ExpandEnvironmentStrings(fn)
  End If

  'ignore g_path
  If Left(fn, 1) = "\" Then
    outs = outs & fn & vbCrLf
    Exit Sub
  End If
  outs = outs & g_path & fn & vbCrLf
  If g_mui = "" Then Exit Sub

  'no mui for folder
  If Right(fn, 1) = "\" Then Exit Sub
  If Right(fn, 4) = ".mui" Then Exit Sub

  ext = ".mui"
  If Right(fn, 4) = ".msc" Then ext = ""
  ext = "\" & fn & ext & vbCrLf
  If InStr(g_mui_list, ",") = 0 Then
    outs = outs & g_path & g_mui_list & ext
    Exit Sub
  End If

  mui_arr = Split(g_mui_list, ",")
  For i = 0 To Ubound(mui_arr)
    outs = outs & g_path & mui_arr(i) & ext
  Next

End Sub
