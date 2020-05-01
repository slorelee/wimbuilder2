var $wb_opt_build = null;

var $wb_opt_src_folder = null;
var $wb_opt_src_index = null;

var $wb_opt_src_wim = null;
var $wb_opt_base_wim = null;
var $wb_opt_base_index = null;

var $wb_opt_project = null;
var $wb_opt_preset = null;
var $wb_opt_makeiso = null;
var $wb_opt_closeui = null;

function analyze_options(env) {
    $wb_opt_build = env('WB_OPT_BUILD');

    $wb_opt_src_folder = env('WB_SRC_FOLDER');
    $wb_opt_src_index = env('WB_SRC_INDEX');

    $wb_opt_src_wim = env('WB_SRC_WIM');
    $wb_opt_base_wim = env('WB_BASE_WIM');
    $wb_opt_base_index = env('WB_BASE_INDEX');

    $wb_opt_project = env('WB_OPT_PROJECT');
    $wb_opt_preset = env('WB_OPT_PRESET');
    $wb_opt_makeiso = env('WB_OPT_MAKE_ISO');
    $wb_opt_closeui = env('WB_OPT_CLOSE_UI');

    if ($wb_opt_makeiso != '') $wb_opt_makeiso = true;

    if ($wb_opt_build != '') {
        if ($wb_opt_build == 'LOG') {
            $wb_opt_build = 'exec';
        } else {
            $wb_opt_build = 'run';
        }
        $app_save_current_preset = false;
        $wb_skip_project_page = true;
        $wb_auto_testiso = false;
    } else {
        $wb_opt_build = null;
        $wb_opt_makeiso = false;
    }

    if ($wb_opt_src_folder != '') {
        $('#wb_src_folder').val($wb_opt_src_folder);
        $wb_base = ''; // auto detect
        wb_src_folder_btn_click(false);
    }

    if ($wb_opt_src_wim != '') {
        $wb_src = $wb_opt_src_wim;
    }

    if ($wb_opt_base_wim != '') {
        $wb_base = $wb_opt_base_wim;
    }

    if ($wb_opt_src_index != '') $wb_src_index = $wb_opt_src_index;
    if ($wb_opt_base_index != '') $wb_base_index = $wb_opt_base_index;

    if ($wb_opt_project != '') $app_default_project = $wb_opt_project;
    if ($wb_opt_preset == '') $wb_opt_preset = null;
    if ($wb_opt_makeiso == true) $wb_auto_makeiso = true;
    if ($wb_opt_closeui != '') $wb_opt_closeui = true;
}

function app_init() {
    page_init();
    start_page_init();
    project_page_init();
    patches_page_init();
    app_mode_init();
}

function page_init() {
    if ($app_root == '') return;
    create_folder_cascade(eformat("_Factory_\\tmp"));
    if ($wb_base == "winre.wim" && fso.FileExists($wb_src)) {
        $('#menu_project').click();
        update_wim_info();
        return;
    }

    if (fso.FileExists($wb_base)) {
        $('#menu_project').click();
        update_wim_info();
        return;
    }

    $('#menu_start').click();
}

function app_mode_init() {
    document.title += ' [' + i18n_t($ui_settings['mode']) + i18n_t(' Mode') + ']';

    if ($ui_settings['mode'] == 'Beginner') {
        $('#wb_src_prompt').text(i18n_t('Please select the mounted Windows ISO drive(eg. H:\\)'));

        $('#wb_install_prompt').hide();
        $('#wb_src').attr("readonly",true);
        $('#wb_src_wim_btn').hide();

        $('#wb_auto_winre').hide();
        $('#label_wb_auto_winre').hide();
        
        $('#wb_base_prompt').hide();
        $('#wb_base').attr("readonly",true);
        $('#wb_base_idx_opt').attr("disabled",true);
        $('#wb_base_wim_btn').hide();

        $('#wb_use_testwim').hide();
        $('#label_wb_use_testwim').hide();
    }
}
