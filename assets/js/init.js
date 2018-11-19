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
i18n_trans();

function page_init() {
    if ($wb_base == "winre.wim" && fso.FileExists($wb_src)) {
        $('#menu_project').click();
        return;
    }

    if (fso.FileExists($wb_base)) {
        $('#menu_project').click();
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

}
