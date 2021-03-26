var $app_root = null;
var $appdata_dir = '';

(function startup_check() {
    var env = wsh.Environment("PROCESS");
    $app_root = env('APP_ROOT');
    if ($app_root == '') {
        var msg = i18n_t('Please startup with ' + $app_name + '.cmd.');
        alert(msg);
        self.close();
    }
    //$app_root = $app_root.substring(0, $app_root.length - 1);
    $app_host_lang = env('APP_HOST_LANG');
    $appdata_dir = env('APPDATA_DIR');
    if ($appdata_dir == '') {
        $appdata_dir = 'AppData';
    }
    if ($app_opt != null) analyze_options(env);
})();

app_init();
i18n_trans();

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
