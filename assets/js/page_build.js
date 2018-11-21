var x_auto_drive = '-';
var _in_building = '';
var _stdout_len = 0;
var _log_path = '';

function build_page_init() {
    $('#build_stdout').empty();
    if (selected_project != null) {
        var msg = 'Do you want to build the [' + selected_project + '] project?';
        var opts = patches_opt_stringify();
        msg += '<br/><br/>' + opts;
        $('#build_stdout').append(msg);
    } else {
        $('#build_stdout').append('No project to build.');
    }

    $("input[name='wb_x_drive'][type='radio'][value='" + $wb_x_drv + "']").prop("checked", true);
    x_drive_detect();
    $("#wb_auto_makeiso").prop("checked", $wb_auto_makeiso);
    var env = wsh.Environment("PROCESS");
    _log_path = env('Factory') + '\\log\\' + selected_project;
}

$("input[name='wb_x_drive'][type='radio']").click(function() {
    $wb_x_drv = $(this).val();
    x_drive_detect();
});

$("#wb_auto_makeiso").click(function() {
    $wb_auto_makeiso = $(this).prop("checked");
});

function x_drive_detect() {
    if ($wb_x_drv != 'auto') {
        $('#x_auto_drive').text('');
        return;
    }
    x_auto_drive = '--';
    var drv_list = ['X', 'A']//, 'B', 'Z', 'Y', 'W', 'V', 'U', 'T', 'S' , 'R', 'Q', 'P', 'O', 'N', 'M', 'L']; // fair enough
    for (var i=0;i<drv_list.length;i++) {
        if (!fso.DriveExists(drv_list[i])) {
            x_auto_drive = drv_list[i] + ':';
            break;
        }
    }
    $('#x_auto_drive').text('(' + x_auto_drive + ')');
}

function x_drive_exists() {
    //var env = wsh.Environment("PROCESS");
    //var sys_drive = env('HOMEDRIVE');
    var drv = $wb_x_drv;
    if (drv == 'auto') drv = x_auto_drive;
    if (fso.DriveExists(drv)) {
        return 1;
    }
    return 0;
}

function structure_env(mode) {
    var env = wsh.Environment("PROCESS");
    env('WB_STRAIGHT_MODE') = $wb_straight_mode;

    env('WB_WORKSPACE') = $wb_workspace;

    env('WB_SRC_FOLDER') = $wb_src_folder;
    env('WB_SRC') = $wb_src;
    env('WB_BASE') = $wb_base;
    env('WB_SRC_INDEX') = $wb_src_index;
    env('WB_BASE_INDEX') = $wb_base_index;


    env('WB_PROJECT') = selected_project;
    env('WB_SKIP_UFR') = $wb_skip_ufr;
    env('WB_SKIP_URR') = $wb_skip_urr;
    var drv = $wb_x_drv;
    if (drv == 'auto') drv = x_auto_drive;
    env('WB_X_DRIVE') = drv;
    env('X') = drv;
    env('_WB_EXEC_MODE') = mode;

    //env('WB_OPT_SHELL') = $WB_OPT['shell'];
}

function _cleanup() {
    $('#build_stdout').empty();
    structure_env(1);
    var oExec = wsh.exec('bin\\_cleanup.bat');
    window.setTimeout(function(){wsh.AppActivate('Wim Builder');}, 500);
    update_output(oExec);
}

function x_drive_confirm() {
    var rt_env = this;
    $("#x-drive-confirm").dialog({
      resizable: false,
      height: "auto",
      width: "auto",
      modal: true,
      buttons: [{
          text: i18n_t('Continue'),
          click: function() {
          $(this).dialog("close");
          if (rt_env.build_action == 'cleanup') {
              cleanup(1);
          } else if (rt_env.build_action == 'run_build') {
              run_build(1);
          } else if (rt_env.build_action == 'exec_build') {
              exec_build(1);
          }
        }},
        { text: i18n_t('Cancel'),
          click: function() {
          $(this).dialog("close");
        }
      }]
    });
}

function cleanup(no_confirm) {
    if (selected_project == null) {
        alert('Please select a project for building.');
        return;
    }

    if (x_drive_exists() == 1) {
        if (!no_confirm) {
            this.build_action = 'cleanup';
            x_drive_confirm();
            return;
        }
    }

    window.setTimeout(function(){_cleanup();}, 100);
}

//WshHide 0;WshNormalFocus 1;WshMinimizedNoFocus 6
function run_build(no_confirm) {
    if (selected_project == null) {
        alert('Please select a project for building.');
        return;
    }

    x_drive_detect();
    if (x_drive_exists() == 1) {
        if (!no_confirm) {
            this.build_action = 'run_build';
            x_drive_confirm();
            return;
        }
    }

    $('#build_stdout').empty();
    if ($wb_auto_makeiso) {
        structure_env(1);
    } else {
        structure_env(0);
    }
    dump_patches_selected();
    dump_patches_opt();
    var cmd_mode = "/k";
    _in_building = 'run_build';
    if ($wb_auto_makeiso) {
        wsh.run('NSudoC.exe -UseCurrentConsole -Wait -U:T "' + $wb_root + '\\bin\\_process.bat\"', 1, true);
         make_iso(true);
    } else {
        wsh.run('cmd ' + cmd_mode + ' \"' + $wb_root + '\\bin\\_process.bat\"', 1, true);
    }
}

function exec_build(no_confirm) {
    if (selected_project == null) {
        alert('Please select a project for building.');
        return;
    }

    x_drive_detect();
    if (x_drive_exists() == 1) {
        if (!no_confirm) {
            this.build_action = 'exec_build';
            x_drive_confirm();
            return;
        }
    }

    $('#build_stdout').empty();
    structure_env(1);
    dump_patches_selected();
    dump_patches_opt();
    _in_building = 'exec_build';
    var logfile = _log_path + '\\last_wimbuilder.log';
    var oExec = wsh.exec('NSudoC.exe -UseCurrentConsole -Wait -U:T "' + $wb_root + '\\bin\\_process.bat" 1>"' + logfile + '" 2>&1');
    window.setTimeout(function(){wsh.AppActivate('Wim Builder');}, 500);
    update_output_by_log(oExec);
}

function make_iso(keep) {
    if (selected_project == null) {
        alert('Please select a project for building.');
        return;
    }
    if (!keep) {
        $('#build_stdout').empty();
    }
    structure_env(0);
    wsh.run('cmd /c \"' + $wb_root + '\\bin\\_MakeBootISO.bat\"', 1, true);
}

function sleep(n) {
    var start = new Date().getTime();
    while (true) if (new Date().getTime() - start > n) break;
}

function update_output(oExec) {
    stdout = oExec.StdOut.ReadLine();
    var build_stdout = $('#build_stdout');
    if (stdout.length > 0) {
        build_stdout.append(stdout + '<br/>');
    }
    if (!oExec.StdOut.AtEndOfStream) {
        stdout = oExec.StdOut.ReadLine();
        if (stdout.length > 0) {
            build_stdout.append(stdout + '<br/>');
        }
    }
    if (oExec.status != 0) {
        if (!oExec.StdOut.AtEndOfStream) {
            stdout = oExec.StdOut.ReadAll();
            if (stdout.length > 0) {
                build_stdout.append(stdout + '<br/>');
            }
        }
        build_stdout.scrollTop(build_stdout[0].scrollHeight);
        return;
    }
    build_stdout.scrollTop(build_stdout[0].scrollHeight);
    window.setTimeout(function(){update_output(oExec);}, 100);
}

function update_output_by_log(oExec) {
    var build_stdout = $('#build_stdout');
    var logfile = _log_path + '\\last_wimbuilder.log';
    var text = load_text_file(logfile);
    text = text.replace(/([\r\n]+)/g, '<br/>');
    build_stdout.html(text);
    build_stdout.scrollTop(build_stdout[0].scrollHeight);
    if (oExec.status != 0) {
        if ($wb_auto_makeiso) {
            window.setTimeout(function(){make_iso(true);}, 1000);
        }
        return;
    }
    window.setTimeout(function(){update_output_by_log(oExec);}, 100);
}

