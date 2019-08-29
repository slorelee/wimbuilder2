Dim i
Set objArgs = WScript.Arguments
If objArgs.Count < 2 Then
    WScript.Echo "AddFiles.vbs:Wrong Parmaters."
    WScript.Quit(1)
End If

'For i = 0 To objArgs.Count - 1
'   WScript.Echo "ARGUMENTS(" & i & "):" & objArgs.Item(i)
'Next

Dim g_path, g_mui, g_mui_list, g_ver, g_if_level, g_if_cond(100)
Dim flag_syswow64, g_syswow64

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

Dim fso, f
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Const TristateFalse = 0

Set fso = CreateObject("Scripting.FileSystemObject")

Dim wshShell, env, wim_ver, wim_lang
Set wshShell = WScript.CreateObject("WScript.Shell")
Set env = wshShell.Environment("Process")
wim_ver = env("WB_PE_VER")
wim_lang = env("WB_PE_LANG")

Dim tmp_dir, txt_sysmui, txt_sysres
tmp_dir = env("_WB_TMP_DIR")

Set f = fso.OpenTextFile(tmp_dir & "\_AddFiles_SYSMUI.txt", ForReading)
txt_sysmui = vbCrLf & f.ReadAll() & vbCrLf
f.Close()

txt_sysres = env("ADDFILES_SYSRES")
If txt_sysres = "1" Then
  Set f = fso.OpenTextFile(tmp_dir & "\_AddFiles_SYSRES.txt", ForReading)
  txt_sysres = vbCrLf & f.ReadAll() & vbCrLf
  f.Close()
Else
  txt_sysres = ""
End If

flag_syswow64 = env("ADDFILES_SYSWOW64")
g_syswow64 = ""

Dim regEx_mui, regEx_sysres
Set regEx_mui = New RegExp
regEx_mui.IgnoreCase = True

Set regEx_sysres = New RegExp
regEx_sysres.IgnoreCase = True

Dim bCode, line
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
  line = code_word
  If Left(line, 1) = "\" Then line = Mid(line, 2)
  Dim arr
  arr = Split(line, "#n")
  For i = 0 To Ubound(arr)
    parser(arr(i))
  Next
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

Function eval_if(line)
  Dim cond
  cond = Mid(line, 4)
  If InStr(cond, "%") > 0 Then
      cond = wshShell.ExpandEnvironmentStrings(cond)
  End If
  eval_if = 0
  If eval(cond) Then eval_if = 1
End Function

Function check_if()
  Dim i
  check_if = "pass"
  For i = 0 To g_if_level - 1
    If g_if_cond(i) = 0 Then
      check_if = "skip"
    End If
  Next
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
  ElseIf Left(line, 3) = "+if" Then
    g_if_cond(g_if_level) = eval_if(line)
    g_if_level = g_if_level + 1
    Exit Sub
  ElseIf Left(line, 3) = "-if" Then
    g_if_level = g_if_level - 1
    Exit Sub
  ElseIf Left(line, 9) = "+syswow64" Then
    If flag_syswow64 = "1" Then g_syswow64 = "\Windows\SysWOW64\"
    Exit Sub
  ElseIf Left(line, 9) = "-syswow64" Then
    g_syswow64 = ""
    Exit Sub
  End If

  If Left(line, 5) = "+ver*" Then g_ver = "":Exit Sub
  If Left(line, 4) = "+ver" Then g_ver = line:Exit Sub

  If g_ver <> "" Then
    g_ver = check_ver(g_ver)
    If g_ver = "skip" Then Exit Sub
  End If

  If g_if_level > 0 Then
    If check_if() = "skip" Then Exit Sub
  End If

  Dim i, files
  files = Split(line, ",")
  For i = 0 To Ubound(files)
      addfile(files(i))
  Next
End Sub

Function valid_muifile(fp)
  Dim fn, ext, muifile, pattern
  valid_muifile = ""
  fn = Mid(fp, InStrRev(fp,"\") + 1)

  ext = ".mui"
  If Right(fn, 4) = ".msc" Then ext = ""
  If InStr(1, fp, "\SysWOW64\", vbTextCompare) > 0 Then
    muifile = "\Windows\SysWOW64\" & wim_lang & "\" & fn & ext
  Else
    muifile = "\Windows\System32\" & wim_lang & "\" & fn & ext
  End If

  If InStr(1, fn, "*") > 0 Then
    pattern = Replace(muifile, "\", "\\")
    pattern =  Replace(pattern, ".", "\.")
    pattern =  Replace(pattern, "*", ".*")
    regEx_mui.Pattern = pattern
    If regEx_mui.Test(txt_sysmui) Then
      valid_muifile = muifile
    End If
    Exit Function
  End If

  If InStr(1, txt_sysmui, vbCrLf & muifile & vbCrLf, vbTextCompare) > 0 Then valid_muifile = muifile
End Function

Function valid_munfile(fp)
  Dim fn, munfile, pattern
  valid_munfile = ""
  fn = Mid(fp, InStrRev(fp,"\") + 1) 
  munfile = "\Windows\SystemResources\" & fn & ".mun"

  If InStr(1, fn, "*") > 0 Then
    pattern = Replace(munfile, "\", "\\")
    pattern =  Replace(pattern, ".", "\.")
    pattern =  Replace(pattern, "*", ".*")
    regEx_sysres.Pattern = pattern
    If regEx_sysres.Test(txt_sysres) Then
      valid_munfile = munfile
    End If
    Exit Function
  End If

  If InStr(1, txt_sysres, vbCrLf & munfile & vbCrLf, vbTextCompare) > 0 Then valid_munfile = munfile
End Function


Sub addfile(fn)
  Dim i, ext, mui_arr, munfile, muifile

  If InStr(fn, "%") > 0 Then
    fn = wshShell.ExpandEnvironmentStrings(fn)
  End If

  'ignore g_path
  If Left(fn, 1) = "\" Then
    'ignore SysWOW64 files
    If flag_syswow64 <> "1" Then
      If InStr(1, fn, "\Windows\SysWOW64\") = 1 Then Exit Sub
    End If
    outs = outs & fn & vbCrLf
    Exit Sub
  End If

  'ignore SysWOW64 files
  If flag_syswow64 <> "1" And g_path = "\Windows\SysWOW64\" Then Exit Sub

  outs = outs & g_path & fn & vbCrLf

  'append mun file
  If txt_sysres <> "" Then
    munfile = valid_munfile(g_path & fn)
    If munfile <> "" Then outs = outs & munfile & vbCrLf
  End If

  If g_syswow64 <> "" Then
    outs = outs & g_syswow64 & fn & vbCrLf
  End If

  If g_mui = "" Then
      'append mui file
      muifile = valid_muifile(g_path & fn)
      If muifile <> "" Then outs = outs & muifile & vbCrLf
      If g_syswow64 <> "" Then
        muifile = valid_muifile(g_syswow64 & fn)
        If muifile <> "" Then outs = outs & muifile & vbCrLf
      End If
      Exit Sub
  End If

  'no mui for folder
  If Right(fn, 1) = "\" Then Exit Sub
  If Right(fn, 4) = ".mui" Then Exit Sub

  ext = ".mui"
  If Right(fn, 4) = ".msc" Then ext = ""
  ext = "\" & fn & ext & vbCrLf
  If InStr(g_mui_list, ",") = 0 Then
    outs = outs & g_path & g_mui_list & ext
    If g_syswow64 <> "" Then outs = outs & g_syswow64 & g_mui_list & ext
    Exit Sub
  End If

  mui_arr = Split(g_mui_list, ",")
  For i = 0 To Ubound(mui_arr)
    outs = outs & g_path & mui_arr(i) & ext
    If g_syswow64 <> "" Then outs = outs & g_syswow64 & mui_arr(i) & ext
  Next

End Sub
