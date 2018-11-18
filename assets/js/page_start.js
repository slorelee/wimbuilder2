var user_trigger = false;

function check_wim_file() {
    var install_wim = 0;
    if (!fso.FileExists($wb_src)) {
        $("#wb_src_alert").show();
    } else {
        $("#wb_src_alert").hide();
        install_wim = 1;
    }

    if (fso.FileExists($wb_base)) {
        $("#wb_base_alert").hide();
        return;
    }

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
    $('#wb_src').val($wb_src);
    $('#wb_base').val($wb_base);
    $('#wb_src_idx_opt').val($wb_src_index);
    $('#wb_base_idx_opt').val($wb_base_index);
    check_wim_file();
    user_trigger = true;
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
    var found = auto_detect_wims(path);
    if (found["install.wim"] == 0) {
        found = auto_detect_wims(path + '\\sources');
    }

    check_wim_file();
}

$('#wb_src_folder_btn').click(function(){
    wb_src_folder_btn_click(true);
});

$('#wb_src_wim_btn').click(function(){
    BrowseFile('#wb_src');
    $wb_src = $('#wb_src').val();
    check_wim_file();
});

$('#wb_base_wim_btn').click(function(){
    BrowseFile('#wb_base');
    $wb_base = $('#wb_base').val();
    check_wim_file();
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
        $wb_src = $(this).val();
        check_wim_file();
    }
});

$("#wb_base").change(function(){
    if (user_trigger) {
        $wb_base = $(this).val();
       check_wim_file();
    }
});

$('#wb_src_idx_opt').click(function(){
    $wb_src_index = $(this).val();
});

$('#wb_base_idx_opt').click(function(){
    $wb_base_index = $(this).val();
});
