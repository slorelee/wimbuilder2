var shApp = new ActiveXObject("Shell.Application");

//BROWSEINFO
var BIF_RETURNONLYFSDIRS = 0x00000001;

//ShellSpecialFolderConstants
var ssfDESKTOP           = 0x00;
var ssfDRIVES            = 0x11; //MyComputer

function BrowseFolder(msg) {
    var p = "";

    var folder = shApp.BrowseForFolder(0, msg, BIF_RETURNONLYFSDIRS, ssfDRIVES);
    if (folder != null) {
        p = folder.Self.Path;
    }
    return p;
}

function OpenFolder(path) {
    if (fso.FolderExists(path)) Run(path);
}

function OpenFile(path) {
    if (fso.FileExists(path)) Run(path);
}
