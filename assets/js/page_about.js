function update_me() {
  if ($ui_settings['update_source'] == 'github' && !fso.FileExists(env('Factory') + "\\tmp\\remote.md5")) {
    var msg = i18n_t('Will update from %s, you can change the update source in [Settings] page.');
    msg = msg.replace('%s', $("#ui_update option:selected").text());
    alert(msg);
  }

  app_env_init();
  Run('_Updater.cmd')
}

function restart_me() {
  Run('WimBuilder.cmd');
  window.close();
}
