var ForReading = 1;
var fso = new ActiveXObject("Scripting.FileSystemObject");

function get_subdirs(parentdir) {
    var arr = new Array();
    var folder = fso.GetFolder(parentdir);
    var fenum = new Enumerator(folder.SubFolders);
    for (var i = 0 ; !fenum.atEnd();i++) {
        arr.push(fenum.item().Name);
        fenum.moveNext();
    }
    return arr;
}