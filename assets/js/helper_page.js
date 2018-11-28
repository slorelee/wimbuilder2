var auto_save_trigger = false;
var _auto_saved_settings = "";

function BrowseFile(elem) {
    var f = document.getElementById('$f');
    f.value = '';
    f.click();
    if (!elem) return f.value;
    $(elem).val(f.value);
}

function get_current_settings() {
    var text = '';
    text += '$wb_auto_config_created=' + $wb_auto_config_created + ";\r\n";
    text += '$wb_show_quick_build=' + $wb_show_quick_build + ";\r\n";
    text += '$width=' + $width + ";\r\n";
    text += '$height=' + $height + ";\r\n";
    text += '$wb_src_folder="' + $wb_src_folder + "\";\r\n";
    text += '$wb_src="' + $wb_src + "\";\r\n";
    text += '$wb_base="' + $wb_base + "\";\r\n";
    text = text.replace(/\\/g, '\\\\');
    text += '$wb_auto_winre=' + $("#wb_auto_winre").prop("checked") + ";\r\n";
    text += '$wb_src_index="' + $wb_src_index + "\";\r\n";
    text += '$wb_base_index="' + $wb_base_index + "\";\r\n";

    if (selected_project != null) $wb_default_project = selected_project;
    text += '$wb_default_project="' + $wb_default_project + "\";\r\n";
    text += '$wb_skip_project_page=' + $wb_skip_project_page + ";\r\n";

    text += '$wb_x_subst=' + $wb_x_subst + ";\r\n";
    text += '$wb_x_drv="' + $wb_x_drv + "\";\r\n";
    text += '$wb_auto_makeiso=' + $wb_auto_makeiso + ";\r\n";
    return text;
}

function auto_save_settings() {
    if (!auto_save_trigger) return;
    $wb_auto_config_created = true;
    var current_settings = get_current_settings();
    if (current_settings != _auto_saved_settings) {
        _auto_saved_settings = current_settings;
        save_text_file($wb_root + '\\auto_config.js', current_settings);
    }
}


function do_quick_build() {
    var jump_page = '';
    if ($wb_base == 'winre.wim') {
        if (!$('#wb_auto_winre').prop('checked')) {
            jump_page = 'start';
        } else {
            if (!fso.FileExists($wb_src)) jump_page = 'start';
        }
    } else if (!fso.FileExists($wb_base)) {
        jump_page = 'start';
    }

    if (jump_page == '' && selected_project == null) {
        jump_page = 'project';
    }

    if (jump_page != '') {
        if (_current_page != jump_page) $('#menu_' + jump_page).click();
        return;
    }

    $('#menu_build').click();

    var mode = 'exec';
    if ($('#quick_build_mode_run').prop('checked')) mode = 'run';

    cleanup(false, mode != 'exec');

    window.setTimeout(function(){wait_and_build(mode);}, 500);
}

function wait_and_build(mode) {
    if (_in_cleanup == 'pre') return;
    if (_in_cleanup != 'done') {
        //waiting
        window.setTimeout(function(){wait_and_build(mode);}, 500);
        return;
    }

    if (mode == 'run') {
        run_build(false, true);
    } else {
        exec_build(false, true);
    }
}