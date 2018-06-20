var user_trigger = false;

function start_page_init() {
    user_trigger = false;
    $('#wb_workspace').val($wb_workspace);
    $('#wb_src').val($wb_src);
    $('#wb_base').val($wb_base);
    $('#wb_src_idx_opt').val($wb_src_index);
    $('#wb_base_idx_opt').val($wb_base_index);
    user_trigger = true;
}

$('#wb_workspace_folder_btn').click(function(){
    $('#wb_workspace').val(BrowseFolder($i18n['Select build workspace folder:']))
    $wb_workspace = $(this).val();
});

$('#wb_src_wim_btn').click(function(){
    BrowseFile('#wb_src');
    $wb_src = $('#wb_src').val();
});

$('#wb_src_folder_btn').click(function(){
    $('#wb_src').val(BrowseFolder($i18n['Select the extracted install.wim folder:']))
    $wb_src = $('#wb_src').val();
    $wb_src_index = -1;
    $('#wb_src_idx_opt').val(-1);
});

$('#wb_base_wim_btn').click(function(){
    BrowseFile('#wb_base');
    $wb_base = $('#wb_base').val();
});


$("#wb_workspace").change(function(){
    if (user_trigger) $wb_workspace = $(this).val();
});

$("#wb_src").change(function(){
    if (user_trigger) $wb_src = $(this).val();
});

$("#wb_base").change(function(){
    if (user_trigger) $wb_base = $(this).val();
});

$('#wb_src_idx_opt').click(function(){
    $wb_src_index = $(this).val();
});

$('#wb_base_idx_opt').click(function(){
    $wb_base_index = $(this).val();
});
