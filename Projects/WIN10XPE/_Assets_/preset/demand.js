var $patches_opt = {
    "build.load_hive_demand":true,
    "build.main_filereg_disabled":true,
    "build.last_filereg_disabled":true,
    "_._._":""
};

if ($ui_settings['mode'] == 'Beginner') {
    $patches_opt = {};
    alert(i18n_t("This preset couldn't work in Beginner Mode."));
}

//advanced operation
function patches_state_init() {
    uncheck_tree_node('_CustomFiles_');
    uncheck_tree_node('00-Configures');
    uncheck_tree_node('01-Components');
    uncheck_tree_node('01-Drivers');
    uncheck_tree_node('02-Apps');
    uncheck_tree_node('02-PEMaterial');
    uncheck_tree_node('za-Slim');
    open_tree_node('00-Configures');
    open_tree_node('01-Components');
    select_tree_node('00-Configures');
}
