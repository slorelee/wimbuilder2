var _settings_page_inited = false;

function settings_page_init() {
    if (_settings_page_inited) return;

    $("input[name='app.mode'][value='" + $ui_settings['mode'] + "']").prop("checked", true);

    update_lang_list();
    update_theme_list();

    _settings_page_inited = true;
}

function settings_page_apply() {
    //$('#ui_lang').find("option:selected")
    //load_theme($ui_settings['theme'], true);
}

$("#settings_form input:radio[name='app.mode']").change(function() {
    $ui_settings['mode'] = $(this).val();
    settings_changed_action();
});

$("#ui_lang").change(function() {
    $ui_settings['lang'] = $(this).val();
    settings_changed_action();
});

$("#ui_theme").change(function() {
    $ui_settings['theme'] = $(this).val();
    settings_changed_action();
});

$("#ui_dpi").change(function() {
    $ui_settings['dpi'] = $(this).val();
    if ($ui_settings['dpi'] == '') {
        dpi_adapt('100');
    } else {
        dpi_adapt($ui_settings['dpi']);
    }
});

$("#settings_restart_yes").click(function() {
    Run('WimBuilder.cmd');
    window.close();
});

$("#settings_restart_no").click(function() {
    $("#settings_float_menu").hide();
});

function settings_changed_action(){
    $("#settings_float_menu").show();
}

function update_lang_list() {
    $('#ui_lang').empty();
    $('#ui_lang').append('   <option value="">'
        + i18n_t('Auto') + ' (' + $app_host_lang + ')' + '</option>');
    var items = get_files('assets\\i18n');
    var opt_selected = false;
    items.forEach(function(item) {
        var name = item.slice(0, -3);
        var select_tag = '';
        if ($ui_settings['lang'] == name) {
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
        if ($ui_settings['theme'] == item) {
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
