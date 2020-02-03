var $width = 1000;
var $height = 800;

var $lang = ''; //auto

var $wb_auto_config_created = false;
var $wb_auto_save_window_size = true;

var $ui_settings = {};
$ui_settings['lang'] = '';
$ui_settings['enable_theme_loader'] = true;
$ui_settings['theme'] = '';
$ui_settings['dpi'] ='';

var $wb_show_quick_build = false;

var $wb_straight_mode = '1';

var $wb_workspace = '.';
var $wb_src_folder = '';
var $wb_src = 'D:\\sources\\install.wim';
var $wb_base = 'D:\\sources\\winre.wim';
var $wb_auto_winre = true;
var $wb_src_index = '1';
var $wb_base_index = '1';

var $wb_skip_project_page = false;
var $wb_default_project = '';

var $wb_save_current_preset = true;

var $wb_x_subst = true;
var $wb_x_drv = 'auto';

var $wb_waitfor_options = 2000;
var $wb_waitfor_build = 2000;

var $wb_auto_makeiso = false;
var $wb_auto_testiso = false;
var $wb_test_cmd = '';

var $iso_boot_file = 'bootmgr';

//skip update files' rights operation
var $wb_skip_ufr = '1';
//skip update registry's rights operation
var $wb_skip_urr = '1';
