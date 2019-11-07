var $wb_root = null;

var $wb_opt_build = null;
var $wb_opt_project = null;
var $wb_opt_preset = null;
var $wb_opt_makeiso = null;

(function startup_check() {
    var env = wsh.Environment("PROCESS");
    $wb_root = env('WB_ROOT');
    if ($wb_root == '') {
        var msg = i18n_t('Please startup with WimBuilder.cmd.');
        alert(msg);
        self.close();
    }
    //$wb_root = $wb_root.substring(0, $wb_root.length - 1);
    $wb_opt_build = env('WB_OPT_BUILD')
    $wb_opt_project = env('WB_OPT_PROJECT');
    $wb_opt_preset = env('WB_OPT_PRESET');
    $wb_opt_makeiso = env('WB_OPT_MAKE_ISO');

    if ($wb_opt_build != '') {
        $wb_skip_project_page = true;
        if ($wb_opt_build == 'LOG') {
            $wb_opt_build = 'exec';
        } else {
            $wb_opt_build = 'run';
        }
    } else {
        $wb_opt_build = null;
    }

    if ($wb_opt_project != '') $wb_default_project = $wb_opt_project;
    if ($wb_opt_preset == '') $wb_opt_preset = null;
    if ($wb_opt_makeiso != '') $wb_auto_makeiso = true;

})();

page_init();
start_page_init();
project_page_init();
i18n_trans();

function page_init() {
    if ($wb_root == '') return;
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

function i18n_trans() {
    $('.i18n-text').each(function(){
        $(this).text($i18n[$(this).text()]);
    });

    $('.i18n-html').each(function(){
       // turn the tag names into lowercase(compatibility for IE8)
        var key = $(this).html();
        key = key.replace(/<([^<]+)>/gi, function (x) {
            return x.toLowerCase();
        });
        $(this).html($i18n[key]);
    });

    $('.i18n-title').each(function(){
        $(this).attr('title', $i18n[$(this).attr('title')]);
    });

    $('.i18n-placeholder').each(function(){
        $(this).attr('placeholder', $i18n[$(this).attr('placeholder')]);
    });

}
