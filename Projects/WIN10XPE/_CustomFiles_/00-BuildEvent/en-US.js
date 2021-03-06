set_default_option('build.preprocess_wim', false);
set_default_option('build.mount_wim_action', 'built_in');
set_default_option('build.load_hive', true);
set_default_option('build.precommit_wim', true);
set_default_option('build.commit_wim_action', 'built_in');
set_default_option('build.custom_iso', true);

if ($app_host_lang != $lang || $app_host_lang != 'zh-CN') {
    set_default_option('build.preprocess_wim_script', '_PreProcessWimFile.bat');
    set_default_option('build.mount_wim_script', '_MountWimFile.bat');
    set_default_option('build.precommit_wim_script', '_PreCommitWimFile.bat');
    set_default_option('build.commit_wim_script', '_CommitWimFile.bat');
}
