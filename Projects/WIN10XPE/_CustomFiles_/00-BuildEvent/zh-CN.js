patch_name = "构建事件";

patch_i18n = {
    "Use Custom ISO Script":"使用自定义ISO做成脚本",
    "Pre-Process WIM file":"预处理WIM映像",
    "Mount WIM file action":"挂载WIM映像动作",
    "Built-in":["默认"],
    "None":["不处理"],
    " Custom":[" 自定义"],
    "Load Registry Hive":"加载注册表配置单元文件",
    "Pre-Commit WIM file":"预提交WIM映像",
    "Commit WIM file action":"保存WIM映像的更改动作"
}


if ($app_host_lang == $lang) {
    set_default_option('build.preprocess_wim_script', '_00-预处理WIM映像.bat');
    set_default_option('build.mount_wim_script', '_10-挂载WIM映像.bat');
    set_default_option('build.precommit_wim_script', '_80-预提交WIM映像.bat');
    set_default_option('build.commit_wim_script', '_90-保存WIM映像.bat');
}
