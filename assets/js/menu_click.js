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
    build_page_init();
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

