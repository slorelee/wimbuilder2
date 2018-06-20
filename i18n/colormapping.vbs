Set objColorStrDic = CreateObject("scripting.dictionary")

CLR_Add "CUSTOM", ""
CLR_Add "PHRASE", "96m"
CLR_Add "WARN", "93m"
CLR_Add "ERROR", "97;101m"

Sub CLR_Add(macro, colorcode)
  objColorStrDic.Add macro, colorcode
End Sub

Function CLR_Trans(macro)
  If objColorStrDic.Exists(macro) Then
    CLR_Trans = "\033[" & objColorStrDic.Item(macro)
    Exit Function
  End If
  CLR_Trans = "\033[" & Replace(macro, ":", ";")
End Function
