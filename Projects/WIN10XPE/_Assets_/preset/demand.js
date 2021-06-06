var $patches_opt = {
    "build.preprocess_wim":false,
    "build.load_hive":false,
    "build.precommit_wim":true,
    "build.commit_wim_action":"none",
    "_._._":""
};

if ($ui_settings['mode'] == 'Beginner') {
    $patches_opt = {};
    alert(i18n_t("This preset couldn't work in Beginner Mode."));
}

//advanced operation
function patches_state_init() {
    uncheck_tree_node('_CustomFiles_/10-PlainCustom');
    uncheck_tree_node('00-Configures');
    uncheck_tree_node('01-Components');
    uncheck_tree_node('01-Drivers');
    uncheck_tree_node('02-Apps');
    uncheck_tree_node('02-PEMaterial');
    uncheck_tree_node('za-Slim');
    open_tree_node('_CustomFiles_');
    open_tree_node('00-Configures');
    open_tree_node('01-Components');
    select_tree_node('_CustomFiles_/00-BuildEvent');
}
