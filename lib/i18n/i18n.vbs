If WSH.Arguments.Count = 0 Then WSH.Quit(0)
If WSH.Arguments.Count = 1 Then
    WSH.Echo GetLocaleName()
    WSH.Quit(0)
End If

Function GetLocaleName()
    Set objLocaleDic = CreateObject("scripting.dictionary")
    objLocaleDic.Add "1025", "ar-SA"
    objLocaleDic.Add "1026", "bg-BG"
    objLocaleDic.Add "1029", "cs-CZ"
    objLocaleDic.Add "1030", "da-DK"
    objLocaleDic.Add "1031", "de-DE"
    objLocaleDic.Add "1032", "el-GR"
    objLocaleDic.Add "1033", "en-US"
    objLocaleDic.Add "3082", "es-ES"
    objLocaleDic.Add "1061", "et-EE"
    objLocaleDic.Add "1035", "fi-FI"
    objLocaleDic.Add "1036", "fr-FR"
    objLocaleDic.Add "1037", "he-IL"
    objLocaleDic.Add "1050", "hr-HR"
    objLocaleDic.Add "1038", "hu-HU"
    objLocaleDic.Add "1040", "it-IT"
    objLocaleDic.Add "1041", "ja-JP"
    objLocaleDic.Add "1042", "ko-KR"
    objLocaleDic.Add "1063", "lt-LT"
    objLocaleDic.Add "1062", "lv-LV"
    objLocaleDic.Add "1044", "nb-NO"
    objLocaleDic.Add "1043", "nl-NL"
    objLocaleDic.Add "1045", "pl-PL"
    objLocaleDic.Add "1046", "pt-BR"
    objLocaleDic.Add "2070", "pt-PT"
    objLocaleDic.Add "1048", "ro-RO"
    objLocaleDic.Add "1049", "ru-RU"
    objLocaleDic.Add "1051", "sk-SK"
    objLocaleDic.Add "1060", "sl-SI"
    objLocaleDic.Add "1053", "sv-SE"
    objLocaleDic.Add "1054", "th-TH"
    objLocaleDic.Add "1055", "tr-TR"
    objLocaleDic.Add "1058", "uk-UA"
    objLocaleDic.Add "2052", "zh-CN"
    objLocaleDic.Add "3076", "zh-HK"
    objLocaleDic.Add "1028", "zh-TW"

    Dim lcid
    lcid = GetLocale()
    If objLocaleDic.Exists(CStr(lcid)) Then
        GetLocaleName = objLocaleDic.Item(CStr(lcid))
    Else
        GetLocaleName = lcid
    End If
End Function

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
