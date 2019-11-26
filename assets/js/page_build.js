var x_auto_drive = '-';
var _in_cleanup = 'pre';
var _in_makeiso = 'pre';
var _in_building = '';
var _stdout_len = 0;
var _log_path = '';

function build_page_init() {
    $('#build_stdout').empty();
    if (selected_project != null) {
        var msg = i18n_t('Do you want to build the [%s] project?');
        msg = msg.replace('%s', selected_project);
        var opts = patches_opt_stringify();
        msg += '<br/><br/>' + opts;
        $('#build_stdout').append(msg);
    } else {
        $('#build_stdout').append(i18n_t('No project to build.'));
    }

    $("input[name='wb_x_drive'][type='radio'][value='" + $wb_x_drv + "']").prop("checked", true);
    x_drive_detect();
    $("#wb_auto_makeiso").prop("checked", $wb_auto_makeiso);
    $("#wb_auto_testiso").prop("checked", $wb_auto_testiso);
    $("#wb_test_cmd").val($wb_test_cmd);

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

$("#wb_auto_testiso").click(function() {
    $wb_auto_testiso = $(this).prop("checked");
});

$("#wb_test_cmd").change(function() {
    $wb_test_cmd = $(this).val();
});

function check_iso_template() {
    var iso_path = eformat('%WB_ROOT%\\_ISO_');
    if (!fso.FolderExists(iso_path)) {
        fso.CreateFolder(iso_path);
    }
    if ($iso_boot_file != '') {
        if (!fso.FileExists(iso_path + '\\' + $iso_boot_file)) {
            var boot_folder = $wb_src_folder;
            if (boot_folder.substr(-1, 1) != '\\') {
                boot_folder += '\\';
            }
            boot_folder += 'boot';
            if (!fso.FolderExists(boot_folder)) {
                alert(i18n_t('The _ISO_ folder is not available, you can\'t create bootable ISO image.\r\nPlease make your ISO template manually, or select the Windows ISO folder/drive for auto creating.'));
            }
        }
    }
}

function x_drive_detect() {
    if ($wb_x_drv != 'auto') {
        $('#x_auto_drive').text('');
        return;
    }
    x_auto_drive = '--';
    var drv_list = ['X', 'A', 'B', 'Z', 'Y', 'W', 'V', 'U', 'T', 'S' , 'R', 'Q', 'P', 'O', 'N', 'M', 'L']; // fair enough
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
    env('WB_VER_STR') = $wb_verstr;
    env('WB_STRAIGHT_MODE') = $wb_straight_mode;

    env('WB_WORKSPACE') = $wb_workspace;

    var src_folder = $wb_src_folder;
    if (src_folder.substr(-1, 1) == '\\') {
        src_folder = src_folder.slice(0, -1);
    }
    env('WB_SRC_FOLDER') = src_folder;
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

function _cleanup(no_activate) {
    _in_cleanup = 'doing';
    $('#build_stdout').empty();
    structure_env(1);
    var oExec = wsh.exec('bin\\_cleanup.bat');
    if (!no_activate) window.setTimeout(function(){wsh.AppActivate('Wim Builder');}, 500);
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

function cleanup(no_confirm, no_activate) {
    if (selected_project == null) {
        alert(i18n_t('Please select a project for building.'));
        return;
    }
    _in_cleanup = 'pre';
    if (x_drive_exists() == 1) {
        if (!no_confirm) {
            this.build_action = 'cleanup';
            x_drive_confirm();
            return;
        }
    }

    window.setTimeout(function(){_cleanup(no_activate);}, 100);
}

//WshHide 0;WshNormalFocus 1;WshMinimizedNoFocus 6
function run_build(no_confirm, keep) {
    if (selected_project == null) {
        alert(i18n_t('Please select a project for building.'));
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

    if (!keep) $('#build_stdout').empty();

    var cmd_mode = '/k';
    if ($wb_auto_makeiso) cmd_mode = '/c';
    if ($wb_opt_closeui) cmd_mode = '/c';
    structure_env(0);
    dump_patches_selected();
    dump_patches_opt();

    _in_building = 'run_build';
    wsh.run('cmd /d ' + cmd_mode + ' "' + $wb_root + '\\bin\\_process.bat"', 1, true);
    _in_building = 'done';
    if ($wb_auto_makeiso) {
        window.setTimeout(function(){
            make_iso(true, 'exec'); //show result in OUTPUT textarea if auto makeiso
        }, $wb_waitfor_build);
    } else  if ($wb_opt_closeui) {
        wait_and_close(); // close directly
    }
}

function exec_build(no_confirm, keep) {
    if (selected_project == null) {
        alert(i18n_t('Please select a project for building.'));
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

    if (!keep) $('#build_stdout').empty();
    structure_env(1);
    dump_patches_selected();
    dump_patches_opt();
    _in_building = 'exec_build';
    var logfile = _log_path + '\\last_wimbuilder.log';
    create_folder_cascade(_log_path);
    var oExec = wsh.exec('cmd /c NSudoC.exe -UseCurrentConsole -Wait -U:T _process.bat 1>"' + logfile + '" 2>&1');
    //var oExec = wsh.exec('cmd /c _process.bat 1>"' + logfile + '" 2>&1');
    window.setTimeout(function(){wsh.AppActivate('Wim Builder');}, 500);
    update_output_by_log(oExec);
}

function make_iso(keep, mode) {
    check_iso_template();
    _in_makeiso = 'pre';
    if (selected_project == null) {
        alert(i18n_t('Please select a project for building.'));
        return;
    }
    if (!keep) {
        $('#build_stdout').empty();
        dump_patches_opt();
    } else {
        $('#build_stdout').append('<br/>Creating ISO...<br/>');
    }
    if (typeof(mode) == 'undefined') structure_env(0);
    _in_makeiso = 'doing';
    if (mode == 'exec') {
        structure_env(1);
        var oExec = wsh.exec('_MakeBootISO.bat');
        window.setTimeout(function(){wsh.AppActivate('Wim Builder');}, 500);
        update_output(oExec);
    } else {
        wsh.run('cmd /d /c _MakeBootISO.bat', 1, true);
    }
    if ($wb_auto_testiso) {
        wait_and_test();
    }
    if ($wb_opt_closeui) {
        wait_and_close();
    }
}

function test_iso() {
    var cmd = $('#wb_test_cmd').val();
    if (cmd == '') return;

    var name = cmd.split(' ')[0];
    var param = cmd.substr(name.length + 1);
    name = $wb_root + '\\test\\' + name;
    if (fso.FileExists(name)) {
        wsh.run('"' + name + '" ' + param, 1, false);
    } else {
        alert(i18n_t('The system cannot find the file specified.') + '\r\n' + name);
    }
}

function wait_and_test() {
    if (_in_makeiso == 'pre') return;
    if (_in_makeiso != 'done') {
        //waiting
        window.setTimeout(function(){wait_and_test();}, 500);
        return;
    }
    test_iso();
}

function wait_and_close() {
    var wait_cond = true;
    if ($wb_opt_makeiso == true) {
        wait_cond = (_in_makeiso != 'done');
    } else {
        wait_cond = (_in_building != 'done');
    }
    if (wait_cond) {
        //waiting
        window.setTimeout(function(){wait_and_close();}, 2000);
        return;
    }
    window.close();
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
                stdout = stdout.replace(/([\r\n]+)/g, '\r\n<br/>');
                build_stdout.append(stdout + '<br/>');
            }
        }
        if (_in_cleanup == 'doing') _in_cleanup = 'done';
        if (_in_makeiso == 'doing') _in_makeiso = 'done';
        build_stdout.scrollTop(build_stdout[0].scrollHeight);
        return;
    }
    build_stdout.scrollTop(build_stdout[0].scrollHeight);
    window.setTimeout(function(){update_output(oExec);}, 100);
}

function update_output_by_log(oExec, finished) {
    var build_stdout = $('#build_stdout');
    var logfile = _log_path + '\\last_wimbuilder.log';
    var text = load_text_file(logfile);
    text = text.replace(/([\r\n]+)/g, '<br/>');
    build_stdout.html(text);
    build_stdout.scrollTop(build_stdout[0].scrollHeight);
    if (oExec.status != 0) {
        if (finished == 1) {
            _in_building = 'done';
            if ($wb_auto_makeiso) {
               window.setTimeout(function(){make_iso(true, 'exec');}, 1000);
            } else  if ($wb_opt_closeui) {
                wait_and_close(); // close directly
            }
        } else {
            window.setTimeout(function(){update_output_by_log(oExec, 1);}, 100);
        }
        return;
    }
    window.setTimeout(function(){update_output_by_log(oExec);}, 100);
}

