var Shell = new ActiveXObject("Shell.Application");
var ws = new ActiveXObject("WScript.Shell")

//BROWSEINFO
var BIF_RETURNONLYFSDIRS = 0x00000001;

//ShellSpecialFolderConstants
var ssfDESKTOP           = 0x00;
var ssfDRIVES            = 0x11; //MyComputer

function BrowseFolder(msg) {
    var p = "";

    var folder = Shell.BrowseForFolder(0, msg, BIF_RETURNONLYFSDIRS, ssfDRIVES);
    if (folder != null) {
        p = folder.Self.Path;
    }
    return p;
}

function Run(file) {
    ws.Run(file);
}

function OpenFolder(path){
    Run(path);
}
