function update_me() {
  app_env_init();
  Run('_Updater.cmd')
}

function restart_me() {
  Run('WimBuilder.cmd');
  window.close();
}
