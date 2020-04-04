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
    var settings_keys = Object.keys($ui_settings);
    settings_keys.forEach(function(key, i) {
        if (typeof($ui_settings[key]) == 'string') {
            text += '$ui_settings[\'' + key + '\']=\"' + $ui_settings[key] + "\";\r\n";
        } else {
            text += '$ui_settings[\'' + key + '\']=' + $ui_settings[key] + ";\r\n";
        }
    })
    text += '$width=' + $width + ";\r\n";
    text += '$height=' + $height + ";\r\n";

    if (selected_project != null) $app_default_project = selected_project;
    text += '$app_default_project="' + $app_default_project + "\";\r\n";
    text += '$app_auto_config_created=' + $app_auto_config_created + ";\r\n";

    text += '$wb_show_quick_build=' + $wb_show_quick_build + ";\r\n";

    text += '$wb_src_folder="' + $wb_src_folder + "\";\r\n";
    text += '$wb_src="' + $wb_src + "\";\r\n";
    text += '$wb_base="' + $wb_base + "\";\r\n";
    text = text.replace(/\\/g, '\\\\');
    text += '$wb_auto_winre=' + $("#wb_auto_winre").prop("checked") + ";\r\n";
    text += '$wb_src_index="' + $wb_src_index + "\";\r\n";
    text += '$wb_base_index="' + $wb_base_index + "\";\r\n";

    text += '$wb_skip_project_page=' + $wb_skip_project_page + ";\r\n";

    text += '$wb_x_subst=' + $wb_x_subst + ";\r\n";
    text += '$wb_x_drv="' + $wb_x_drv + "\";\r\n";
    text += '$wb_auto_makeiso=' + $wb_auto_makeiso + ";\r\n";
    text += '$wb_auto_testiso=' + $wb_auto_testiso + ";\r\n";
    text += '$wb_test_cmd="' + $wb_test_cmd + "\";\r\n";
    return text;
}

function auto_save_settings() {
    if (!auto_save_trigger) return;
    $app_auto_config_created = true;
    var current_settings = get_current_settings();
    if (current_settings != _auto_saved_settings) {
        _auto_saved_settings = current_settings;
        save_text_file($app_root + '\\auto_config.js', current_settings);
    }
}


function do_quick_build(mode) {
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

    if (mode == null) $('#menu_patch').click();
    $('#menu_build').click();

    if (mode == null) {
        mode = 'exec';
        if ($('#quick_build_mode_run').prop('checked')) mode = 'run';
    }
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


var last_src_key = '';
var last_base_key = '';
var _last_src_info = '';
var _last_base_info = '';
function update_wim_info() {
    var status = '';
    var src_info = _last_src_info;
    var base_info = _last_base_info;
    var src_key = $wb_src + '[' + $wb_src_index + ']';
    var base_key = $wb_base + '[' + $wb_base_index + ']';

    if ($wb_src == '' || $wb_src_index == '-1' || !fso.FileExists($wb_src)) {
        src_info = 'source.wim[-]:-(-,-,-)';
    } else if (src_key != last_src_key) {
        var n = get_file_name($wb_src);
        src_info = n + '[' + $wb_src_index + ']:' + exec_cmd('\"GetWimInfo.cmd\" \"' + $wb_src + '\" ' + $wb_src_index);
        last_src_key = $wb_src + '[' + $wb_src_index + ']';
        _last_src_info = src_info;
    }

    if ($wb_base == 'winre.wim') {
        base_info = 'winre.wim[1]:' + src_info.split(':')[1];
    } else if ($wb_base == '' || $wb_base_index == '-1' || !fso.FileExists($wb_base)) {
        base_info = 'base.wim[-]:-(-,-,-)';
    } else if (base_key != last_base_key) {
        var n = get_file_name($wb_base);
        base_info = n + '[' + $wb_base_index + ']:' + exec_cmd('\"GetWimInfo.cmd\" \"' + $wb_base + '\" ' + $wb_base_index);
        last_base_key = $wb_base + '[' + $wb_base_index + ']';
        _last_base_info = base_info;
    }

    $('#status_text').text(base_info); //src_info + ' ' + base_info
}
