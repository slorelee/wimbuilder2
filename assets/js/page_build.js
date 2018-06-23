function structure_env(mode) {
    var env = wsh.Environment("PROCESS");
    env('WB_STRAIGHT_MODE') = $wb_straight_mode;

    env('WB_WORKSPACE') = $wb_workspace;
    env('WB_SRC') = $wb_src;
    env('WB_BASE') = $wb_base;
    env('WB_SRC_INDEX') = $wb_src_index;
    env('WB_BASE_INDEX') = $wb_base_index;


    env('WB_PROJECT') = selected_project;
    env('WB_SKIP_UFR') = $wb_skip_ufr;
    env('WB_SKIP_URR') = $wb_skip_urr;

    env('_WB_EXEC_MODE') = mode;
    //env('WB_OPT_SHELL') = $WB_OPT['shell'];
}

function _cleanup() {
    $('#build_stdout').empty();
    structure_env(1);
    var oExec = wsh.exec('bin\\_cleanup.bat');
    var stdout = null;
    var b = null;
    window.setTimeout(function(){wsh.AppActivate('Wim Builder');}, 500);
    update_output(oExec);
}

function cleanup() {
    if (selected_project == null) {
        alert('Please select a project for building.');
        return;
    }
    window.setTimeout(function(){_cleanup();}, 100);
}

//WshHide 0;WshNormalFocus 1;WshMinimizedNoFocus 6
function run_build() {
    if (selected_project == null) {
        alert('Please select a project for building.');
        return;
    }
    $('#build_stdout').empty();
    structure_env(0);
    wsh.run('cmd /k bin\\_process.bat', 1, true);
}

function exec_build() {
    if (selected_project == null) {
        alert('Please select a project for building.');
        return;
    }
    $('#build_stdout').empty();
    structure_env(1);
    var oExec = wsh.exec('bin\\_process.bat');
    var stdout = null;
    var b = null;
    window.setTimeout(function(){wsh.AppActivate('Wim Builder');}, 500);
    update_output(oExec);
}

function make_iso() {
    if (selected_project == null) {
        alert('Please select a project for building.');
        return;
    }
    $('#build_stdout').empty();
    structure_env(0);
    wsh.run('cmd /c bin\\_MakeBootISO.bat', 1, true);
}

function sleep(n) {
    var start = new Date().getTime();
    while (true) if (new Date().getTime() - start > n) break;
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

