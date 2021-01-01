Set objArgs = WScript.Arguments
If objArgs.Count < 1 Then
    WScript.Echo "[ERROR] CleanupDeviceIds.vbs:Wrong Parmaters."
    WScript.Quit(1)
End If

Dim dir, infdir
dir = objArgs.Item(0)
infdir = dir & "\Windows\INF"

Const ForReading = 1, ForWriting = 2, ForAppending = 8
Const TristateTrue = -1
Const TristateFalse = 0

Dim fso, f
Set fso = CreateObject("Scripting.FileSystemObject")

Set f = fso.OpenTextFile("_DriverDeviceIds.reg", ForReading, False, TristateTrue)
deviceids = f.ReadAll()
f.Close()

Dim i, n, arr, arr_out
arr = Split(deviceids, vbCrLf)
Redim arr_out(UBound(arr))

arr_out(0) = "Windows Registry Editor Version 5.00"
arr_out(1) = vbCrLf
n = 2

Dim key_line, inf_num, file_num, file_list, file_arr, inf_name
For i = 4 To UBound(arr) - 1
  If arr(i) = "" Then
    If i <> key_line + 1 Then
      'WSH.echo "[" & inf_num & ":" & file_num & "]" & file_list
      If inf_num = file_num Then
        ' Remove key
        arr_out(n) = file_list
        arr_out(n + 1) = "[-" & Mid(arr(key_line), 2)
        n = n + 2
      ElseIf file_num > 0 Then
        ' Remove value(s)
        arr_out(n) = arr(key_line)
        file_arr = Split(Mid(file_list, 2), ";")
        arr_out(n + 1) = """" & join(file_arr, """=-" & vbCrLf & """") & """=-"
        n = n + 2
      End If
    End If
  ElseIf Left(arr(i), 1) = "[" Then
    key_line = i
    inf_num = 0
    file_num = 0
    file_list = ""
  ElseIf Left(arr(i), 1) = """" Then
    inf_num = inf_num + 1
    inf_name = Mid(arr(i), 2, InStr(2, arr(i), """") - 2)
    'MsgBox inf_name
    If Not fso.FileExists(infdir & "\" & inf_name) Then
      file_num = file_num + 1
      file_list = file_list & ";" & inf_name
    End If
  End If
Next

Redim Preserve arr_out(n)

Set f = fso.CreateTextFile("_RemoveDriverDeviceIds.reg", ForWriting)
f.Write(join(arr_out, vbCrLf))
f.Close()
