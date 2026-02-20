var fso = new ActiveXObject("Scripting.FileSystemObject");

var folderPath = WScript.Arguments(0);
var flagFilePath = WScript.Arguments(1);

var dirCount = 0;

if (!fso.FolderExists(folderPath)) {
    WScript.Echo("Target folder not found.");
    WScript.Quit(2);
}

var folder = fso.GetFolder(folderPath);
var fc = new Enumerator(folder.SubFolders);

for (; !fc.atEnd(); fc.moveNext()) {
    dirCount++;
}

WScript.Echo("Directory count: " + dirCount);

if (dirCount === 1) {
    var flagFile = fso.CreateTextFile(flagFilePath, true);
    flagFile.WriteLine("PASS");
    flagFile.Close();
}

WScript.Quit(0);