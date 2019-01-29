var $patches_opt = {
    "build.source":"light",
    "build.registry.software":"merge",
    "build.wow64support":false,           // always false if ARCH=x86
    "system.admin_enabled":false,
    "system.admin_countdown":"5",
    "system.admin_screen": "wallpaper",
    "system.darktheme":false,
    "theme.title_color":"1",
    "config.fbwf.cache": "2048",
    "config.computername": "WINXPE",
    "shell.app":"explorer",
    "shell.wallpaper": project.full_path + "\\_CustomFiles_\\wallpaper.jpg",
    "tweak.shortcut.noarrow":false,
    "tweak.shortcut.nosuffix":true,
    "component.mspaint":true,
    "component.winphotoview":true
};

//advanced operation
function patches_state_init() {
    open_tree_node('00-Configures');
    select_tree_node('00-Configures/Build');
    uncheck_tree_node('02-Apps');
    uncheck_tree_node('MTP_Support');
    uncheck_tree_node('Patch_drvinst');
    uncheck_tree_node('01-Components');
    check_tree_node('01-Components/00-Shell');
    check_tree_node('01-Components/DWM');
    check_tree_node('01-Components/IME');
    check_tree_node('01-Components/MMC');
    check_tree_node('01-Components/za-Accessories');
    open_tree_node('01-Components');
}





/*
var $patches_state = {
    "opened":[
      "01-Components"
    ],
    "selected":[],
    "unselected":[]
}
*/