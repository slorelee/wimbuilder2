objArgs = WScript.Arguments
for (i = 1; i < objArgs.length; i++) {
   WScript.Echo('ARGUMENTS('+ i+ '):' + objArgs(i))
}
var code_file = objArgs(1)
var code_word = objArgs(2)

var fso = new ActiveXObject("Scripting.FileSystemObject")
var ForReading = 1, ForWriting = 2
f = fso.OpenTextFile(code_file, ForReading)
var bCode = false
var line = ''
var codes = ''
line = f.Readline()
while (!f.AtEndOfStream) {
   line = f.ReadLine()
   if (!bCode && line == 'goto ' + code_word) {
       bCode = true;
   } else if (line == code_word) {
       break;
   } else if (bCode) {
       codes += line + "\r\n"
   }
}
f.Close()
eval(codes)

