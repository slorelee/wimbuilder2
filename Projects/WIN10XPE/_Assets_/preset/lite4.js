var $patches_opt = {
    "build.source":"light",
    "build.registry.software":"merge",
    "build.catalog":"light",
    "build.wow64support":true,           // always false if ARCH=x86
    "system.admin_enabled":false,
    "system.admin_countdown":"5",
    "system.admin_screen": "wallpaper",
    "system.darktheme":false,
    "theme.title_color":"1",
    "config.fbwf.cache": "2048",
    "config.computername": "LITEPE",
    "shell.app":"explorer",
    "shell.wallpaper": project.full_path + "\\_CustomFiles_\\wallpaper.jpg",
    "tweak.shortcut.noarrow":false,
    "tweak.shortcut.nosuffix":true,
    "component.MMC":true,
    "component.DWM":true,
    "component.vcruntime":false,
    "component.mspaint":false,
    "component.winphotoviewer":false,
    "network.builtin_drivers":false,
    "slim.mui":true,
    "slim.winboot":true,
    "slim.font.mingliu":true,
    "slim.jscript":true,
    "slim.hta":true,
    "slim.wmi":true,
    "slim.speech":true,
    "slim.small_fonts":true,
    "slim.small_imageresdll":true,
    "slim.ultra":true,
    "_._._":""
};

//advanced operation
function patches_state_init() {
    open_tree_node('00-Configures');
    uncheck_tree_node('02-Apps');
    uncheck_tree_node('01-Components');
    check_tree_node('01-Components/00-Shell');
    open_tree_node('01-Components');
    uncheck_tree_node('01-Drivers');
    check_tree_node('za-SlimExtra');

    select_tree_node('00-Configures/Build');
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