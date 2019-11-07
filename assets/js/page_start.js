var $_wb_first_run = false;

var user_trigger = false;

function check_wim_file() {
    var install_wim = 0;
    if (!fso.FileExists($wb_src)) {
        $("#wb_src_alert").show();
        $('#wb_src_wiminfo').hide();
    } else {
        $("#wb_src_alert").hide();
        install_wim = 1;
        update_src_wiminfo();
        $('#wb_src_wiminfo').show();
    }

    if (fso.FileExists($wb_base)) {
        $("#wb_base_alert").hide();
        update_base_wiminfo();
        $('#wb_base_wiminfo').show();
        return;
    }

    $('#wb_base_wiminfo').hide();
    if ($wb_base.substr(1, 1) == ":") {
       $("#wb_base_alert").show();
    } else {
        if (install_wim == 1 && $("#wb_auto_winre").prop("checked") == true) {
            $wb_base = "winre.wim";
            $("#wb_base").val($wb_base);
            $("#wb_base_alert").hide();
        } else {
            $("#wb_base_alert").show();
        }
    }
}

function start_page_init() {
    user_trigger = false;
    $('#wb_workspace').val($wb_workspace);
    $('#wb_src_folder').val($wb_src_folder);
    $('#wb_src').val($wb_src);
    $('#wb_base').val($wb_base);
    $('#wb_auto_winre').prop('checked', $wb_auto_winre);
    if ($wb_base == '') {
        wb_src_folder_btn_click(false);
    }
    $('#wb_src_idx_opt').val($wb_src_index);
    $('#wb_base_idx_opt').val($wb_base_index);
    check_wim_file();
    _auto_saved_settings = get_current_settings();
    auto_save_trigger = true;
    user_trigger = true;
    if (!$wb_auto_config_created) {
        $_wb_first_run = true;
        $('#page_start_info').show();
    }
}

$('#wb_workspace_folder_btn').click(function(){
    $('#wb_workspace').val(BrowseFolder($i18n['Select build workspace folder:']))
    $wb_workspace = $(this).val();
});

function auto_detect_wims(src_path) {
    var found = {
        "install.wim":0,
        "winre.wim":0,
        "boot.wim":0
    };
    var wim_file = src_path + '\\install.wim';
    if (fso.FileExists(wim_file)) {
        $wb_src = wim_file;
        found["install.wim"] = 1;
    }

    wim_file = src_path + '\\winre.wim';
    if (fso.FileExists(wim_file)) {
        $wb_base = wim_file;
        found["winre.wim"] = 1;
    } else {
        wim_file = src_path + '\\boot.wim';
        if (fso.FileExists(wim_file)) {
            $wb_base = wim_file;
            found["boot.wim"] = 1;
        }
    }

    if ($("#wb_auto_winre").prop("checked") == true) {
        if (found["install.wim"] == 1 && found["winre.wim"] == 0) {
            $wb_base = "winre.wim";
            found["winre.wim"] = 1;
        }
    }

    $("#wb_src").val($wb_src);
    $("#wb_base").val($wb_base);
    return found;
}

function wb_src_folder_btn_click(event) {
    if (event) {
        $('#wb_src_folder').val(BrowseFolder($i18n['Select the extracted install.wim folder:']));
    }
    var path = $('#wb_src_folder').val();
    $wb_src_folder = path;
    if (path == '') return;
    $('#wb_use_testwim').prop('checked', false);
    if (path.slice(-1) == '\\') path = path.slice(0, -1);
    var found = auto_detect_wims(path);
    if (found["install.wim"] == 0) {
        found = auto_detect_wims(path + '\\sources');
    }

    check_wim_file();
}

function wb_src_wim_btn_click(event) {
    if (event) {
        BrowseFile('#wb_src');
    }
    //$('#wb_src_folder').val('');
    //$wb_src_folder = '';
    $wb_src = $('#wb_src').val();
    check_wim_file();
}

function wb_base_wim_btn_click(event, testwim_event) {
    if (event) {
        BrowseFile('#wb_base');
    }
    //$('#wb_src_folder').val('');
    //$wb_src_folder = '';
    if (!testwim_event) $('#wb_use_testwim').prop('checked', false);
    $wb_base = $('#wb_base').val();
    check_wim_file();
}

$('#wb_src_folder_btn').click(function(){
    wb_src_folder_btn_click(true);
});

$('#wb_src_wim_btn').click(function(){
    wb_src_wim_btn_click(true);
});

$('#wb_auto_winre').click(function(){
    check_wim_file();
});

$('#wb_use_testwim').click(function(){
    var use_testwim = $(this).prop('checked');
    if (use_testwim) {
      $('#wb_base').val('test\\boot.wim');
      $wb_base_index = 1;
      $('#wb_base_idx_opt').val($wb_base_index);
    } else {
         $('#wb_base').val('');
    }
    wb_base_wim_btn_click(false, true);
});


$('#wb_base_wim_btn').click(function(){
    wb_base_wim_btn_click(true);
});


$("#wb_workspace").change(function(){
    if (user_trigger) $wb_workspace = $(this).val();
});

$("#wb_src_folder").change(function(){
    if (user_trigger) {
        wb_src_folder_btn_click(false);
    }
});

$("#wb_src").change(function(){
    if (user_trigger) {
        wb_src_wim_btn_click(false);
    }
});

$("#wb_base").change(function(){
    if (user_trigger) {
        wb_base_wim_btn_click(false);
    }
});

$('#wb_src_idx_opt').click(function(){
    $wb_src_index = $(this).val();
    update_src_wiminfo();
});

$('#wb_base_idx_opt').click(function(){
    $wb_base_index = $(this).val();
    update_base_wiminfo();
});

function update_src_wiminfo() {
    if ($wb_src_index != -1) {
        update_wim_info();
        $('#wb_src_wiminfo').text(_last_src_info);
    } else {
        $('#wb_src_wiminfo').text('source.wim[-]:-(-,-,-)');
    }
}

function update_base_wiminfo() {
    if ($wb_base_index != -1) {
        update_wim_info();
        $('#wb_base_wiminfo').text(_last_base_info);
    } else {
        $('#wb_base_wiminfo').text('base.wim[-]:-(-,-,-)');
    }
}
