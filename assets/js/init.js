var $wb_root = null;

(function startup_check() {
    var env = wsh.Environment("PROCESS");
    $wb_root = env('WB_ROOT');
    if ($wb_root == '') {
        var msg = 'Please startup with WimBuilder.cmd.';
        alert(msg);
        self.close();
    }
    $wb_root = $wb_root.substring(0, $wb_root.length - 1);
})();

page_init();
start_page_init();
i18n_init();
i18n_trans();

function page_init() {
    if (!fso.FileExists($wb_base)) {
        $('#menu_start').click();
        return;
    }
    $('#menu_project').click();
}

function i18n_init() {
    if (typeof($lang) == "undefined") return;
    if ($lang == '') {
        var env = wsh.Environment("PROCESS");
        $lang = env('WB_UI_LANG');
    }

    var text = load_utf8_file('assets/i18n/' + $lang + '.json');
    if (text != "") $i18n = JSON.parse(text);
}

function i18n_trans() {
    $('.i18n-text').each(function(){
        $(this).text($i18n[$(this).text()]);
    });

    $('.i18n-title').each(function(){
        $(this).attr('title', $i18n[$(this).attr('title')]);
    });

}