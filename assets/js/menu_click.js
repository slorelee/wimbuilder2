$('#menu_start').click(function(){
    switch_page('start');
});

$('#menu_project').click(function(){
    switch_page('project');
    show_projects();
});

$('#menu_patch').click(function(){
    switch_page('patch');
});

$('#menu_build').click(function(){
    switch_page('build');
    $('#build_stdout').empty();
    if (selected_project != null) {
        $('#build_stdout').append('Do you want to build the [' + selected_project + '] project?');
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

