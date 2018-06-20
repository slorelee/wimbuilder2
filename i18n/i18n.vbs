If WSH.Arguments.Count = 0 Then WSH.Quit(0)
If WSH.Arguments.Count = 1 Then
    WSH.Echo GetLocale()
    WSH.Quit(0)
End If

Set objI18nStrDic = CreateObject("scripting.dictionary")
Set objI18nRegExpDic = CreateObject("scripting.dictionary")
Class I18n
    Private Sub Class_Initialize
    End Sub
    Private Sub Class_Terminate
    End Sub
    Public Sub s(str, trans)
      objI18nStrDic.Add str, trans
    End Sub
    Public Sub r(regexp, trans)
      objI18nRegExpDic.Add regexp, trans
    End Sub

    Public Function trans(str)
        trans = str
      'direct match
      If objI18nStrDic.Exists(str) Then
          trans = objI18nStrDic.Item(str)
          Exit Function
      End If

      'part match
      Dim objKeys, i, p
     objKeys = objI18nStrDic.Keys
     For i = 0 To objI18nStrDic.Count - 1
        p = InStr(1, str, objKeys(i))
        If p > 0 Then
            trans = Replace(str, objKeys(i), objI18nStrDic.Item(objKeys(i)))
          Exit Function
        End If
      Next

      'TODO:RegExp match
    End Function
End Class
Set t = New I18n

Sub Trans()
    Dim modestr, mode, colorstr, transstr, f, i, pos
    f = 1
    modestr = WSH.Arguments(0)
    mode = "ECHO"
    colorstr = ""
    If InStr(1, modestr, "LOG") > 0 Then mode = "LOG"
    If InStr(1, modestr, "CLR") = 1 Then
       colorstr = WSH.Arguments(0)
       'f = f + 1
      pos = InstrRev(colorstr, "_")
       colorstr = CLR_Trans(Mid(colorstr, pos + 1))
    End If
    transstr = t.trans(WSH.Arguments(f))
    For i = f + 1 To WSH.Arguments.Count - 1
        transstr = Replace(transstr, "@s", WSH.Arguments(i), 1, 1)
    Next
    Select Case mode
    Case "ECHO"
        WSH.Echo colorstr & transstr
    Case "LOG"
        WSH.Echo colorstr & transstr
        WSH.Echo  log_prefix() & Left("INFO" & Space(10), 10) & transstr
    Case Else
         WSH.Echo transstr
    End Select
End Sub

Function log_prefix()
    dim N
    N = Now()
    log_prefix = Year(N) & "-" & Right("0" & Month(N), 2) & "-" & Right("0" & Day(N), 2) & " " 
    log_prefix = log_prefix & Right("0" & Hour(N), 2) & ":" & Right("0" & Minute(N), 2) & ":" & Right("0" & Second(N), 2) & ","
End Function
