var $patches_opt = {
    "build.source":"light",
    "build.registry.software":"merge",
    "build.catalog":"auto",
    "build.wow64support":false,           // always false if ARCH=x86
    "account.admin_enabled":false,
    "account.autologon_countdown":"5",
    "account.admin_screen": "wallpaper",
    "system.darktheme":false,
    "theme.title_color":"1",
    "config.fbwf.cache": "2048",
    "config.computername": "WINXPE",
    "system.workgroup": "WORKGROUP",
    "system.high_compatibility":true,
    "shell.app":"explorer",
    "shell.wallpaper": project.full_path + "\\_CustomFiles_\\wallpaper.jpg",
    "tweak.shortcut.noarrow":false,
    "tweak.shortcut.nosuffix":true,
    "component.MMC":true,
    "component.DWM":true,
    "component.vcruntime":true,
    "component.mspaint":true,
    "component.winphotoviewer":true,
    "IME.indicator":true,
    "IME.system_ime":true,
    "IE.x64_component":"x64+x86",
    "IE.custom_settings":true,
    "IE.home_page":"about:blank",
    "network.function_discovery":true,
    "network.builtin_drivers":true,
    "slim.winboot":false,
    "_._._":""
};

//advanced operation
function patches_state_init() {
    select_tree_node('_CustomFiles_');
    open_tree_node('00-Configures');
    uncheck_tree_node('02-Apps');
    uncheck_tree_node('01-Components');
    check_tree_node('01-Components/00-Shell');
    check_tree_node('01-Components/IME');
    check_tree_node('01-Components/za-Accessories');
    open_tree_node('01-Components');
    uncheck_tree_node('za-SlimExtra');
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