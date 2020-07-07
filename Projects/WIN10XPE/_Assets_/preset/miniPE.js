var $patches_opt = {
    "nodeset.name":"MiniPE",
    "build.source":"light",
    "build.registry.software":"notset",
    "build.registry.drivers":"notset",
    "build.catalog":"auto",
    "build.wow64support":false,           // always false if ARCH=x86
    "loader.name":"system",
    "system.darktheme":false,
    "theme.title_color":"1",
    "config.fbwf.cache": "2048",
    "config.computername": "WINXPE",
    "system.workgroup": "WORKGROUP",
    "system.high_compatibility":true,
    "shell.app":"winxshell",
    "tweak.shortcut.noarrow":false,
    "tweak.shortcut.nosuffix":true,
    "component.MMC":false,
    "component.DWM":false,
    "component.vcruntime":false,
    "component.mspaint":false,
    "component.winphotoviewer":false,
    "slim.mui":true,
    "slim.winre_sources":true,
    "slim.winboot":true,
    "slim.font.mingliu":true,
    "slim.wbem_repository":true,
    "slim.speech":true,
    "slim.ieframedll":true,
    "slim.jscript":true,
    "slim.hta":true,
    "slim.wmi":true,
    "slim.small_fonts":true,
    "slim.small_imageresdll":true,
    "slim.safe":true,
    "slim.extra":true,
    "slim.hive":true,
    "_._._":""
};


function patches_node_init(arr) {
    // alert($patches_preset);
    remove_tree_node(arr, '_CustomFiles_/MyTheme');
    remove_tree_node(arr, '00-Configures/x-Account');
    remove_tree_node(arr, '01-Components/02-Network');
    remove_tree_node(arr, '01-Components/03-Audio');
    remove_tree_node(arr, '01-Components/Bluetooth');
    remove_tree_node(arr, '01-Components/Devices and Printers');
    remove_tree_node(arr, '01-Components/IME');
    remove_tree_node(arr, '01-Components/Internet Explorer');
    remove_tree_node(arr, '01-Components/Remote Desktop');
    remove_tree_node(arr, '01-Components/Windows Media Player');
    remove_tree_node(arr, '01-Drivers');
    return arr;
}

//advanced operation
function patches_state_init() {
    open_tree_node('00-Configures');
    open_tree_node('00-Configures/00-Shell');
    open_tree_node('01-Components');
    uncheck_tree_node("01-Components/00-Shell/za-StartMenu");
    uncheck_tree_node("02-Apps");
    check_tree_node("02-Apps/7-Zip");
    uncheck_tree_node("02-PEMaterial");
    check_tree_node("02-PEMaterial/00-MyMaterial");
    check_tree_node("02-PEMaterial/01-Maintenance");
    check_tree_node("za-SlimUltra");
    //uncheck_tree_node("00-Configures/Build");
    select_tree_node("zb-MiniPE");
}
