$width = 1208;
$height = 800;
$app_auto_save_window_size = true;

$lang = '';

$ui_settings['lang'] = $lang;
$ui_settings['theme'] = '';

if (eformat('x%APP_HOST_WIN%') == 'x10') {
    $ui_settings['theme'] = 'picture';
}

$wb_src_folder = '';
$wb_src = '';
$wb_base = '';

$wb_src_index = 1;
$wb_base_index = 1;

// uncomment this to cancel the iso template check
//$iso_boot_file = '';
