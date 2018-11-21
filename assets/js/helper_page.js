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
    var current_settings = get_current_settings();
    if (current_settings != _auto_saved_settings) {
        _auto_saved_settings = current_settings;
        save_text_file($wb_root + '\\auto_config.js', current_settings);
    }
}
