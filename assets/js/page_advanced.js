var _advanced_page_inited = false;

var advcmd_file = 'AppData\\_Advcmd.cmd';

function advanced_page_init() {
    if (_advanced_page_inited) return;
    load_advcmd();
    _advanced_page_inited = true;
}

function clean_advcmd() {
    $('#adv_cmdtext').empty();
}

function load_advcmd() {
    $('#adv_cmdtext').empty();
    var text = load_text_file(advcmd_file, false);
    text = text.replace(/\r\n/g, "\r");
    $('#adv_cmdtext').append(text);
}

function save_advcmd() {
    var text = $('#adv_cmdtext').text();
    text = text.replace(/\r/g, "\r\n");
    save_text_file(advcmd_file, text);
}

function exec_advcmd() {
    save_advcmd();
    var env = wsh.Environment("PROCESS");
    if (selected_project != null) {
        env('WB_PROJECT') = selected_project;
    }
    app_env_init();
    Run(advcmd_file);
}

function advcmd_save_event() {
    if (event.ctrlKey && event.keyCode == 83) {  // Ctrl + S
        save_advcmd();
    }
}