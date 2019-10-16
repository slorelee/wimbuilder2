var $patches_opt = {
    "build.source":"full",
    "build.registry.software":"full",
    "build.full_catalog":true,
    "build.catalog":"full",
    "build.wow64support":true,           // always false if ARCH=x86
    "account.admin_enabled":true,
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
    "component.taskmgr":true,
    "component.bitlocker":true,
    "component.search":true,
    "component.vcruntime":true,
    "component.MSI":true,
    "component.netfx":true,
    "component.MTP":true,
    "component.RNDIS":true,
    "component.mspaint":true,
    "component.winphotoviewer":true,
    "component.snippingtool":true,
    "component.accessibility":true,
    "component.termservice":true,
    "patch.drvinst":true,
    "IME.indicator":true,
    "IME.system_ime":true,
    "IME.ms_pinyin":true,
    "IME.ms_wubi":true,
    "IE.x64_component":"x64+x86",
    "IE.custom_settings":true,
    "IE.home_page":"about:blank",
    "network.function_discovery":true,
    "network.networklist_and_sharecenter":true,
    "network.builtin_drivers":true,
    "audio.win_events":"all",
    "slim.mui":true,
    "slim.winboot":false,
    "slim.font.mingliu":true,
    "slim.jscript":false,
    "slim.hta":false,
    "slim.wmi":false,
    "slim.ultra":false,
    "_._._":""
};

//advanced operation
function patches_state_init() {
    select_tree_node('_CustomFiles_');
    open_tree_node('00-Configures');
    open_tree_node('01-Components');
    uncheck_tree_node('za-Slim');
    //uncheck_tree_node('za-SlimExtra');
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