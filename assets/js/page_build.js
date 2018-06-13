function sleep(n) {
    var start = new Date().getTime();
    while (true) if (new Date().getTime() - start > n) break;
}

//WshHide 0;WshNormalFocus 1;WshMinimizedNoFocus 6
function run_build() {
    if (selected_project == null) {
        alert('Please select a project for building.');
        return;
    }
    $('#build_stdout').empty();
    wsh.run('Projects\\' + selected_project + '\\init.bat',1,true);
}

function exec_build() {
    if (selected_project == null) {
        alert('Please select a project for building.');
        return;
    }
    $('#build_stdout').empty();
    var oExec = wsh.exec('Projects\\' + selected_project + '\\init.bat');
    var stdout = null;
    var b = null;
    update_output(oExec);
}

function update_output(oExec) {
    stdout = oExec.StdOut.ReadLine();
    if (stdout.length > 0) {
        $('#build_stdout').append(stdout + '<br/>');
    }
    if (!oExec.StdOut.AtEndOfStream) {
        stdout = oExec.StdOut.ReadLine();
        if (stdout.length > 0) {
            $('#build_stdout').append(stdout + '<br/>');
        }
    }
    if (oExec.status != 0) {
        if (!oExec.StdOut.AtEndOfStream) {
            stdout = oExec.StdOut.ReadAll();
            if (stdout.length > 0) {
                $('#build_stdout').append(stdout + '<br/>');
            }
        }
        return;
    }
    window.setTimeout(function(){update_output(oExec);}, 100);
}

