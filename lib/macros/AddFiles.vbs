Set objArgs = WScript.Arguments
If objArgs.Count < 3 Then
    WScript.Echo "AddFiles.vbs:Wrong Parmaters."
    WScript.Quit(1)
End If

For i = 0 To objArgs.Count - 1
   WScript.Echo "ARGUMENTS(" & i & "):" & objArgs.Item(i)
Next

Dim g_path, g_mui, g_ver

Dim code_file, code_word, out_file
code_file = objArgs.Item(0)
code_word = objArgs.Item(1)
out_file = objArgs.Item(2)

Dim fso
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Const TristateFalse = 0

Set fso = CreateObject("Scripting.FileSystemObject")

Dim f, bCode, line
Dim outs
outs = ""
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

WSH.echo outs
Set f = fso.OpenTextFile(out_file, ForAppending, True)
f.Write outs
f.Close

Sub parser(line)
  If line = "" Then Exit Sub             'empty line
  If Left(line, 1) = ";" Then Exit Sub   'comment line
  If line = "@-" Then g_path = "":Exit Sub
  If line = "-mui" Then g_mui = "":Exit Sub
  If line = "+mui" Then g_mui = "+":Exit Sub
  If Left(line, 1) = "@" Then g_path = Mid(line, 2):Exit Sub
  If Left(line, 4) = "+ver*" Then g_ver = "":Exit Sub
  If Left(line, 4) = "+ver" Then g_ver = line:Exit Sub

  If g_ver <> "" Then
    'TODO:check ver
  End If

  Dim i, files
  files = Split(line, ",")
  For i = 0 To Ubound(files)
      addfile(files(i))
  Next
End Sub

Sub addfile(fn)
  outs = outs & g_path & fn & vbCrLf
  If g_mui <> "" Then
      outs = outs & g_path & "??\" & fn & ".mui" & vbCrLf
  End If
End Sub
