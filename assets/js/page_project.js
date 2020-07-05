var _auto_selected = false;

function project_page_init() {
    $('#wb_skip_project_page').prop('checked', $wb_skip_project_page);
}

$('#wb_skip_project_page').click(function(){
    $wb_skip_project_page = $(this).prop('checked');
});

function show_projects() {
    var dirs = get_subdirs('Projects');
    $('#project_list').html("");
    var default_in_list = false;
    dirs.forEach(function(item) {
        if (item == $app_default_project) default_in_list = true;
        $('#project_list').append(pj_button(item));
    });

    if (selected_project != null) {
        $('#pj_' + selected_project).text(selected_project + '   *');
        $('#pj_' + selected_project).addClass('project-selected');
    }
    regist_event();

    if (_auto_selected) return;
    _auto_selected = true;
    if (default_in_list) {
        $('#pj_' + $app_default_project).click();
        if ($wb_skip_project_page) $('#menu_patch').click();
    } else if (dirs.length == 1 && $app_default_project == '' && selected_project == null) {
        $('#pj_' + dirs[0]).click();
        if ($wb_skip_project_page) $('#menu_patch').click();
    }
}

function reload_project(name, preset) {
    var project = Project.New(name, preset, true);
    $obj_project = project;
    $patches_opt = project.patches_opt;
    $patches_var = {};
    project.patches_tree_data = Project.GetPatches(project);
    $obj_patches = null;
    $obj_patch = null;
    $patches_preset_inited = null;
    return project;
}

function regist_event() {
    $('.project-button').click(function(){
        var name = $(this).attr('id');
        name = name.substr(3);
        var last_selected_project = selected_project;
        if (selected_project != null) {
            $('#pj_' + selected_project).text(selected_project);
            $('#pj_' + selected_project).removeClass('project-selected');
        }
        selected_project = name;
        $('#pj_' + selected_project).addClass('project-selected');
        $('#pj_' + selected_project).text(name + '   *');
        
        var project = $obj_project;
        if (last_selected_project != selected_project) {
            project = reload_project(name, $wb_opt_preset);
        }
        $('#project_desc').html('<p>' + project.desc.replace(/\r\n/g, '<br/>') + '</p>');
        if (project.desc) {
            var obj = JSON.parse(project.desc);
            //alert('read JSON[description]:' + obj.description);
        }
        $('#project_html').html(project.html);
    })
}



function pj_button(name) {
    return '<button ' + ' id="pj_' + name + '"' +
        ' class="pure-button pure-button-primary project-button">' +
        name + '</button><br/>';
}