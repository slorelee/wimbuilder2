var ForReading = 1;
var ForWriting = 2;

var TristateTrue = -1; // UNICODE
var TristateFalse = 0; // ANSI

var fso = new ActiveXObject("Scripting.FileSystemObject");
var ado = null;

// remove ADODB dependency, i18n resources files' encoding need to be UTF-16LE BOM
// get_ado();

function get_ado() {
    var env = wsh.Environment("PROCESS");
    var path = env('CommonProgramFiles') + "\\System\\ado\\msado15.dll";
    if (fso.FileExists(path)) {
        ado = new ActiveXObject("ADODB.Stream");
    }
}

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

function load_text_file(filename, format) {
    if (!fso.FileExists(filename)) return '';
    if (format == null) format = TristateFalse;
    var objFile = fso.OpenTextFile(filename, ForReading, false, format);
    var text = '';
    if (!objFile.AtEndOfStream) {
        text = objFile.ReadAll();
    }
    objFile.close();
    return text;
}

function load_utf8_file(filename) {
    if (!fso.FileExists(filename)) return '';
    if (ado == null) {
        return load_text_file(filename, TristateTrue);
    }
    ado.Charset = "utf-8";
    ado.Type = 2; //adTypeText  
    ado.Open;
    ado.Position = 0;
    ado.Loadfromfile(filename);
    var text = ado.ReadText(); 
    ado.Close;
    return text;
}

function save_text_file(filename, text) {
    var objFile = fso.CreateTextFile(filename, true);
    objFile.Write(text);
    objFile.close();
}

function create_folder_cascade(path) {
    if (fso.FolderExists(path)) return;
    var arr = path.split("\\");
    var chk_path = '';
    var need_create = false;
    for (var i in arr) {
        chk_path += arr[i] + "\\";
        if (need_create || !fso.FolderExists(chk_path)) {
            fso.CreateFolder(chk_path);
            need_create = true;
        }
    }
}
