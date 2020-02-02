var _settings_page_inited = false;

function settings_page_init() {
    if (_settings_page_inited) return;

    update_lang_list();
    update_theme_list();

    _settings_page_inited = true;
}

function settings_page_apply() {
    //$('#ui_lang').find("option:selected")
    var lang_opt = $('#ui_lang').val();
    var theme_opt = $('#ui_theme').val();

    $wb_settings['theme'] = theme_opt;
    //load_theme($wb_settings['theme'], true);
}

function update_lang_list() {
    $('#ui_lang').empty();
    $('#ui_lang').append('   <option value="Auto">'
        + i18n_t('Auto') + ' (' + $lang + ')' + '</option>');
    var items = get_files('assets\\i18n');
    var opt_selected = false;
    items.forEach(function(item) {
        var name = item.slice(0, -3);
        var select_tag = '';
        if ($wb_settings['lang'] == name) {
            select_tag = 'selected';
            opt_selected = true;
        }
        $('#ui_lang').append('   <option value="' + name +'" ' +
            select_tag + '>' + name + '</option>');
    });
    // select 'Auto'
    if (!opt_selected) {
        $('#ui_lang').find("option").eq(0).prop("selected", true);
    }
}

function update_theme_list() {
    $('#ui_theme').empty();
    $('#ui_theme').append('   <option value="">' + i18n_t('None') + '</option>');
    var items = get_subdirs('assets\\themes');
    var opt_selected = false;
    items.pop(); // remove '_items_'
    items.forEach(function(item) {
        var select_tag = '';
        if ($wb_settings['theme'] == item) {
            select_tag = 'selected';
            opt_selected = true;
        }
        $('#ui_theme').append('   <option value="' + item +'" ' +
            select_tag + '>' + item + '</option>');
    });
    // select 'None'
    if (!opt_selected) {
        $('#ui_theme').find("option").eq(0).prop("selected", true);
    }
}
