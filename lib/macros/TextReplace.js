objArgs = WScript.Arguments
/* for (i = 0; i < objArgs.length; i++) {
   WScript.Echo('ARGUMENTS('+ i+ '):' + objArgs(i))
} */
//WScript.Echo(objArgs.length)

var file = objArgs(0)
var regex = objArgs(1)
var repl = objArgs(2)

//NOTICE: can't use //, so use #// to instead, and remove the first char
if (regex.substr(1, 2) == '//') regex = regex.substr(1)

var fso = new ActiveXObject("Scripting.FileSystemObject")
var ForReading = 1, ForWriting = 2
var f = fso.OpenTextFile(file, ForReading)
var txt = f.readAll()
f.Close()

//NOTICE: #q => ", #s => #, #p => %
regex = regex.replace(/#q/g, '"')
regex = regex.replace(/#p/g, '%')
regex = regex.replace(/#s/g, '#')
repl = repl.replace(/#q/g, '"')
repl = repl.replace(/#p/g, '%')
repl = repl.replace(/#s/g, '#')

//WScript.Echo(regex)
//WScript.Echo(repl)
txt = txt.replace(regex, repl);
f = fso.OpenTextFile(file, ForWriting)
f.Write(txt)
f.Close()
