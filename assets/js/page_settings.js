var _settings_page_inited = false;

function settings_page_init() {
    if (_settings_page_inited) return;

    $("input[name='app.mode'][value='" + $ui_settings['mode'] + "']").prop("checked", true);

    update_lang_list();
    update_theme_list();
    init_update_settings();
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

$("#ui_update").change(function() {
    $ui_settings['update_source'] = $(this).val();
    init_update_settings(true);
});

$('#ui_update_remote_url').change(function() {
    $ui_settings['custom_remote_url'] = $(this).val();
});

$('#ui_update_source_url').change(function() {
    $ui_settings['custom_source_url'] = $(this).val();
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

function init_update_settings(self) {
    var k = $ui_settings['update_source'];

    if (!self) {
        $("#ui_update option[value='" + k + "']").prop("selected", true);
    }
    if (k == 'custom') {
        $('#ui_update_remote_url').val($ui_settings['custom_remote_url']);
        $('#ui_update_source_url').val($ui_settings['custom_source_url']);
    } else {
        $('#ui_update_remote_url').val($update_sources[k]['remote_url']);
        $('#ui_update_source_url').val($update_sources[k]['source_url']);
    }
    enable_custom_update_urls(k);
}

function enable_custom_update_urls(opt) {
    var enabled = false;
    if (opt == 'custom') enabled = true;
    $('#ui_update_remote_url').attr('readonly', !enabled);
    $('#ui_update_source_url').attr('readonly', !enabled);
}
