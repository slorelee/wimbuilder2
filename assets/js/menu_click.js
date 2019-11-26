var _current_page = '';

$('#menu_start').click(function(){
    switch_page('start');
    start_page_init();
});

$('#menu_project').click(function(){
    switch_page('project');
    show_projects();
});

function load_patch_shared_style() {
    if (!$obj_project) return;
    $('#patch_shared_style_holder').html('<link rel="stylesheet" href="' + $obj_project.style + '"/>');
}

$('#menu_patch').click(function(){
    load_patch_shared_style();
    switch_page('patch');
    $('#patch_project_name').text(selected_project);
    update_preset_list();
    show_patches_settings();
    if ($wb_opt_build) {
        window.setTimeout(function(){
            do_quick_build($wb_opt_build);
        }, $wb_waitfor_options);
    }
});

$('#menu_build').click(function(){
    if ($obj_project) {
        update_patches_opt($obj_project.patches_opt, true);
    }
    $wb_show_quick_build = true;
    switch_page('build');
    build_page_init();
});

$('#menu_about').click(function(){
    switch_page('about');
});

function display_quick_build(page) {
    if (page == 'build' || page == 'about') {
        $('#quick_build').hide();
        return;
    }

    if ($wb_show_quick_build) {
        $('#quick_build').show();
    }
}

function switch_page(page) {
    _current_page = page;
    $('.pure-menu-item').removeClass('pure-menu-selected');
    $('#menu_' + page).parent().addClass('pure-menu-selected');

    display_quick_build(page);

    $('.content_page').hide();
    $('#page_' + page).show();
    auto_save_settings();
}

