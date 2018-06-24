@echo off
echo %cd%

call Coder VBS %0 :end_vbs_test parameter1 877
goto :end_vbs_test
dim a
MsgBox WSH.arguments(3)
a = 123 + WSH.arguments(4)
MsgBox a
:end_vbs_test


call Coder JS %0 :end_js_test
goto :end_js_test
function getDate() {
  function padzero(n) {
    return (n < 10 ? '0' : '') + n;
  }

  var date = new Date();
  return '' + date.getFullYear() + '-' +
     padzero(date.getMonth() + 1) + '-' +
     padzero(date.getDate()) + ' ' +
     padzero(date.getHours()) + ':' +
     padzero(date.getMinutes()) + ':' +
     padzero(date.getSeconds());
}

WScript.Echo (getDate())
:end_js_test

pause
exit
