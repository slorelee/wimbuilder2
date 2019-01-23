objArgs = WScript.Arguments
/* for (i = 0; i < objArgs.length; i++) {
   WScript.Echo('ARGUMENTS('+ i+ '):' + objArgs(i))
} */
//WScript.Echo(objArgs.length)

var file = objArgs(0)
var regex = objArgs(1)
var repl = objArgs(2)

//NOTICE: can't use // at begin(cscript.exe's option format), so use #// to instead
if (regex.substr(1, 2) == '//') regex = regex.substr(1)
if (repl.substr(1, 2) == '//') repl = repl.substr(1)

var fso = new ActiveXObject("Scripting.FileSystemObject")
var ForReading = 1, ForWriting = 2
var f = fso.OpenTextFile(file, ForReading)
var txt = f.readAll()
f.Close()

//NOTICE: #q => ", #s => #, #p => %, #t => \t, #r => \r, #n => \n
regex = escape(regex)
repl = escape(repl)

//WScript.Echo(regex)
//WScript.Echo(repl)
txt = txt.replace(regex, repl)
f = fso.OpenTextFile(file, ForWriting)
f.Write(txt)
f.Close()

function escape(str) {
  str = str.replace(/#q/g, '"')
  str = str.replace(/#p/g, '%')

  str = str.replace(/#t/g, '\t')
  str = str.replace(/#r/g, '\r')
  str = str.replace(/#n/g, '\n')

  str = str.replace(/#s/g, '#')
  return str
}