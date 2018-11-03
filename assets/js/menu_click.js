$('#menu_start').click(function(){
    switch_page('start');
    start_page_init();
});

$('#menu_project').click(function(){
    switch_page('project');
    show_projects();
});

$('#menu_patch').click(function(){
    switch_page('patch');
    show_patches_settings();
});

$('#menu_build').click(function(){
    if ($obj_project) {
        update_patches_opt($obj_project.patches_opt);
    }
    switch_page('build');
    $('#build_stdout').empty();
    if (selected_project != null) {
        var msg = 'Do you want to build the [' + selected_project + '] project?';
        var json = JSON.stringify($obj_project.patches_opt);
        json = json.replace(/(\".+?\":.+?),/g, "$1,<br\/>");
        msg += '<br/><br/>' + json;
        $('#build_stdout').append(msg);
    } else {
        $('#build_stdout').append('No project to build.');
    }
});

$('#menu_about').click(function(){
    switch_page('about');
});

function switch_page(page) {
    $('.pure-menu-item').removeClass('pure-menu-selected');
    $('#menu_' + page).parent().addClass('pure-menu-selected');

    $('.content_page').hide();
    $('#page_' + page).show();
}

